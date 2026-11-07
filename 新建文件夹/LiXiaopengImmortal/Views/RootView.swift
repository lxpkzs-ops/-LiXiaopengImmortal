import SwiftUI

struct RootView: View {
    @EnvironmentObject private var store: GameStore
    @State private var selectedTab: GameTab = .story

    var body: some View {
        ZStack(alignment: .top) {
            ImmortalBackground()

            TabView(selection: $selectedTab) {
                StoryView()
                    .tag(GameTab.story)
                    .tabItem { Label(GameTab.story.rawValue, systemImage: GameTab.story.systemImage) }

                StatusView()
                    .tag(GameTab.status)
                    .tabItem { Label(GameTab.status.rawValue, systemImage: GameTab.status.systemImage) }

                RelationsView()
                    .tag(GameTab.relations)
                    .tabItem { Label(GameTab.relations.rawValue, systemImage: GameTab.relations.systemImage) }

                InventoryView()
                    .tag(GameTab.inventory)
                    .tabItem { Label(GameTab.inventory.rawValue, systemImage: GameTab.inventory.systemImage) }

                QuestView()
                    .tag(GameTab.quests)
                    .tabItem { Label(GameTab.quests.rawValue, systemImage: GameTab.quests.systemImage) }
            }
            .tint(ImmortalTheme.gold)

            if let message = store.toastMessage {
                Text(message)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial, in: Capsule())
                    .overlay(Capsule().stroke(ImmortalTheme.gold.opacity(0.45), lineWidth: 1))
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(10)
            }
        }
        .animation(.spring(response: 0.35), value: store.toastMessage)
        .sheet(isPresented: $store.showingSavePanel) {
            SavePanelView()
                .environmentObject(store)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

