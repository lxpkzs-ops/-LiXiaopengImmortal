import Foundation

enum GameTab: String, CaseIterable, Identifiable {
    case story = "剧情"
    case status = "道途"
    case relations = "红颜"
    case inventory = "乾坤袋"
    case quests = "任务"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .story: return "book.pages.fill"
        case .status: return "sparkles"
        case .relations: return "heart.fill"
        case .inventory: return "shippingbox.fill"
        case .quests: return "checklist"
        }
    }
}

struct HeroStats: Codable, Equatable {
    var realmIndex = 0
    var hiddenPower = 9_999
    var qi = 100
    var money = 20_000
    var reputation = 0
    var swagger = 0

    static let realms = [
        "凡人（伪装）", "炼气", "筑基", "金丹", "元婴",
        "化神", "渡劫", "陆地真仙", "诸天至尊"
    ]

    var visibleRealm: String {
        Self.realms[min(max(realmIndex, 0), Self.realms.count - 1)]
    }
}

struct Relationship: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let age: Int
    let title: String
    let symbol: String
    var affection: Int
    var unlocked: Bool
    var lastMemory: String

    var stage: String {
        switch affection {
        case ..<20: return "初识"
        case 20..<45: return "在意"
        case 45..<70: return "心动"
        case 70..<90: return "相知"
        default: return "生死相随"
        }
    }
}

struct InventoryItem: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let description: String
    let rarity: String
    let symbol: String
    var quantity: Int
}

enum QuestStatus: String, Codable {
    case locked = "未解锁"
    case active = "进行中"
    case completed = "已完成"
}

struct Quest: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let detail: String
    let reward: String
    var status: QuestStatus
}

struct GameEffect: Codable, Equatable {
    var qi = 0
    var money = 0
    var reputation = 0
    var swagger = 0
    var realmChange = 0
    var relationshipID: String? = nil
    var affection = 0
    var unlockRelationshipID: String? = nil
    var addItemID: String? = nil
    var addItemQuantity = 0
    var questID: String? = nil
    var questStatus: QuestStatus? = nil
    var setFlags: [String] = []
    var removeFlags: [String] = []
    var toast: String? = nil

    static let none = GameEffect()
}

struct StoryChoice: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let subtitle: String
    let symbol: String
    let nextNodeID: String
    var requiredFlag: String? = nil
    var forbiddenFlag: String? = nil
    var requiredItemID: String? = nil
    var effect: GameEffect = .none
}

struct StoryNode: Codable, Identifiable, Equatable {
    let id: String
    let chapter: Int
    let chapterTitle: String
    let location: String
    let title: String
    let body: String
    let speaker: String?
    let mood: String
    let choices: [StoryChoice]
}

struct GameState: Codable, Equatable {
    var currentNodeID = "c1_arrival"
    var stats = HeroStats()
    var relationships: [Relationship] = GameContent.defaultRelationships
    var inventory: [InventoryItem] = GameContent.defaultInventory
    var quests: [Quest] = GameContent.defaultQuests
    var flags: Set<String> = []
    var history: [String] = []
    var unlockedChapters: Set<Int> = [1]
    var completedNodeIDs: Set<String> = []
    var startedAt = Date()
    var updatedAt = Date()
    var endingTitle: String? = nil
}

struct SaveSlot: Codable, Identifiable, Equatable {
    let id: Int
    let state: GameState
    let savedAt: Date
    let label: String
}
