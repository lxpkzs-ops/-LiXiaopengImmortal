import SwiftUI

struct QuestView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        NavigationStack {
            ZStack {
                ImmortalBackground()
                ScrollView {
                    VStack(spacing: 14) {
                        SectionTitle(eyebrow: "Missions", title: "天命任务")
                        ForEach(store.state.quests) { quest in
                            questCard(quest)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("任务")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func questCard(_ quest: Quest) -> some View {
        HStack(alignment: .top, spacing: 13) {
            ZStack {
                Circle()
                    .fill(statusColor(quest.status).opacity(0.14))
                    .frame(width: 42, height: 42)
                Image(systemName: statusSymbol(quest.status))
                    .foregroundStyle(statusColor(quest.status))
            }
            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    Text(quest.title)
                        .font(.headline)
                    Spacer()
                    Text(quest.status.rawValue)
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(statusColor(quest.status))
                }
                Text(quest.detail)
                    .font(.caption)
                    .foregroundStyle(quest.status == .locked ? Color.gray.opacity(0.65) : Color.gray)
                Label(quest.reward, systemImage: "gift.fill")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(quest.status == .locked ? Color.gray.opacity(0.5) : ImmortalTheme.gold)
            }
        }
        .opacity(quest.status == .locked ? 0.65 : 1)
        .immortalCard()
    }

    private func statusColor(_ status: QuestStatus) -> Color {
        switch status {
        case .locked: return .gray
        case .active: return ImmortalTheme.gold
        case .completed: return ImmortalTheme.jade
        }
    }

    private func statusSymbol(_ status: QuestStatus) -> String {
        switch status {
        case .locked: return "lock.fill"
        case .active: return "exclamationmark"
        case .completed: return "checkmark"
        }
    }
}
