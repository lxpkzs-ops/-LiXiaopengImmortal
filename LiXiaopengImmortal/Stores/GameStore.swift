import Foundation
import Combine

@MainActor
final class GameStore: ObservableObject {
    @Published var state: GameState
    @Published var saveSlots: [SaveSlot?] = Array(repeating: nil, count: 3)
    @Published var toastMessage: String?
    @Published var showingSavePanel = false

    private static let autoSaveKey = "lx_immortal_autosave_v1"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() {
        let startupDecoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: Self.autoSaveKey),
           let loaded = try? startupDecoder.decode(GameState.self, from: data) {
            state = loaded
        } else {
            state = GameState()
        }
        loadSlotMetadata()
    }

    var currentNode: StoryNode {
        GameContent.node(state.currentNodeID) ?? GameContent.node("c1_arrival")!
    }

    var visibleInventory: [InventoryItem] {
        state.inventory.filter { $0.quantity > 0 }
    }

    var unlockedRelationships: [Relationship] {
        state.relationships.filter(\.unlocked)
    }

    var chapterProgress: Double {
        Double(currentNode.chapter) / 8.0
    }

    func isChoiceAvailable(_ choice: StoryChoice) -> Bool {
        if let flag = choice.requiredFlag, !state.flags.contains(flag) { return false }
        if let flag = choice.forbiddenFlag, state.flags.contains(flag) { return false }
        if let itemID = choice.requiredItemID,
           !state.inventory.contains(where: { $0.id == itemID && $0.quantity > 0 }) { return false }
        return true
    }

    func choose(_ choice: StoryChoice) {
        guard isChoiceAvailable(choice) else {
            showToast("条件尚未满足")
            return
        }

        state.completedNodeIDs.insert(currentNode.id)
        state.history.append("第\(currentNode.chapter)章 · \(currentNode.title)：\(choice.title)")
        apply(choice.effect)
        state.currentNodeID = choice.nextNodeID
        if let nextNode = GameContent.node(choice.nextNodeID) {
            state.unlockedChapters.insert(nextNode.chapter)
            if nextNode.choices.isEmpty {
                state.endingTitle = nextNode.title
            }
        }
        state.updatedAt = Date()
        autoSave()
    }

    func save(to slotIndex: Int) {
        guard (0..<3).contains(slotIndex) else { return }
        let slot = SaveSlot(
            id: slotIndex,
            state: state,
            savedAt: Date(),
            label: "第\(currentNode.chapter)章 · \(currentNode.title)"
        )
        guard let data = try? encoder.encode(slot) else { return }
        UserDefaults.standard.set(data, forKey: slotKey(slotIndex))
        saveSlots[slotIndex] = slot
        showToast("已保存到存档 \(slotIndex + 1)")
    }

    func load(from slotIndex: Int) {
        guard (0..<3).contains(slotIndex), let slot = saveSlots[slotIndex] else { return }
        state = slot.state
        autoSave()
        showingSavePanel = false
        showToast("存档 \(slotIndex + 1) 已读取")
    }

    func deleteSlot(_ slotIndex: Int) {
        guard (0..<3).contains(slotIndex) else { return }
        UserDefaults.standard.removeObject(forKey: slotKey(slotIndex))
        saveSlots[slotIndex] = nil
        showToast("存档 \(slotIndex + 1) 已清空")
    }

    func restart(newGamePlus: Bool = false) {
        let oldSwagger = state.stats.swagger
        state = GameState()
        if newGamePlus {
            state.stats.swagger = min(oldSwagger / 4, 100)
            state.stats.money = 1_000_000
            state.flags.insert("new_game_plus")
            if let index = state.inventory.firstIndex(where: { $0.id == "blackcard" }) {
                state.inventory[index].quantity = 1
            }
        }
        autoSave()
        showToast(newGamePlus ? "二周目开启：部分实力已继承" : "新的传奇开始了")
    }

    func formatMoney(_ value: Int) -> String {
        if value >= 100_000_000 { return String(format: "%.1f亿", Double(value) / 100_000_000) }
        if value >= 10_000 { return String(format: "%.1f万", Double(value) / 10_000) }
        return "¥\(value)"
    }

    private func apply(_ effect: GameEffect) {
        state.stats.qi = max(0, state.stats.qi + effect.qi)
        state.stats.money = max(0, state.stats.money + effect.money)
        state.stats.reputation = max(0, state.stats.reputation + effect.reputation)
        state.stats.swagger = max(0, state.stats.swagger + effect.swagger)
        state.stats.realmIndex = min(
            max(0, state.stats.realmIndex + effect.realmChange),
            HeroStats.realms.count - 1
        )

        if let unlockID = effect.unlockRelationshipID,
           let index = state.relationships.firstIndex(where: { $0.id == unlockID }) {
            state.relationships[index].unlocked = true
            if state.relationships[index].lastMemory == "尚未相遇" {
                state.relationships[index].lastMemory = "命运的第一次相遇"
            }
        }

        if let relationshipID = effect.relationshipID,
           let index = state.relationships.firstIndex(where: { $0.id == relationshipID }) {
            state.relationships[index].unlocked = true
            state.relationships[index].affection = min(100, max(0, state.relationships[index].affection + effect.affection))
            state.relationships[index].lastMemory = effect.toast ?? "与你共同经历了「\(currentNode.title)」"
        }

        if let itemID = effect.addItemID,
           let index = state.inventory.firstIndex(where: { $0.id == itemID }) {
            state.inventory[index].quantity = max(0, state.inventory[index].quantity + effect.addItemQuantity)
        }

        if let questID = effect.questID,
           let index = state.quests.firstIndex(where: { $0.id == questID }),
           let status = effect.questStatus {
            state.quests[index].status = status
        }

        effect.setFlags.forEach { state.flags.insert($0) }
        effect.removeFlags.forEach { state.flags.remove($0) }
        if let message = effect.toast { showToast(message) }
    }

    private func autoSave() {
        guard let data = try? encoder.encode(state) else { return }
        UserDefaults.standard.set(data, forKey: Self.autoSaveKey)
    }

    private func loadSlotMetadata() {
        for index in 0..<3 {
            guard let data = UserDefaults.standard.data(forKey: slotKey(index)),
                  let slot = try? decoder.decode(SaveSlot.self, from: data) else { continue }
            saveSlots[index] = slot
        }
    }

    private func slotKey(_ index: Int) -> String { "lx_immortal_slot_\(index)_v1" }

    private func showToast(_ message: String) {
        toastMessage = message
        Task { [weak self] in
            try? await Task.sleep(nanoseconds: 2_200_000_000)
            if self?.toastMessage == message { self?.toastMessage = nil }
        }
    }
}
