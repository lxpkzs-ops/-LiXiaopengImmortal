import SwiftUI

struct StoryView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        NavigationStack {
            ZStack {
                ImmortalBackground()
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            Color.clear.frame(height: 1).id("storyTop")
                            chapterHeader
                            storyCard

                            if store.currentNode.choices.isEmpty {
                                endingActions
                            } else {
                                choiceList
                            }

                            Spacer(minLength: 30)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                    }
                    .onChange(of: store.state.currentNodeID) { _ in
                        withAnimation(.easeOut(duration: 0.35)) {
                            proxy.scrollTo("storyTop", anchor: .top)
                        }
                    }
                }
            }
            .navigationTitle("逆天仙尊")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Label(store.state.stats.visibleRealm, systemImage: "sparkles")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(ImmortalTheme.gold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        store.showingSavePanel = true
                    } label: {
                        Image(systemName: "square.and.arrow.down.fill")
                    }
                    .accessibilityLabel("存档")
                }
            }
        }
    }

    private var chapterHeader: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text("第 \(store.currentNode.chapter) 章 / 8")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(ImmortalTheme.gold)
                    Text(store.currentNode.chapterTitle)
                        .font(.title2.bold())
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 3) {
                    Text("爽点")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text("\(store.state.stats.swagger)")
                        .font(.title3.monospacedDigit().bold())
                        .foregroundStyle(ImmortalTheme.gold)
                }
            }
            ProgressView(value: store.chapterProgress)
                .tint(ImmortalTheme.gold)
        }
        .immortalCard()
    }

    private var storyCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 8) {
                Label(store.currentNode.location, systemImage: "mappin.and.ellipse")
                Spacer()
                Text(store.currentNode.mood)
            }
            .font(.caption.weight(.medium))
            .foregroundStyle(ImmortalTheme.gold.opacity(0.9))

            Text(store.currentNode.title)
                .font(.system(size: 29, weight: .heavy, design: .serif))
                .foregroundStyle(.white)

            if let speaker = store.currentNode.speaker {
                Text("「\(speaker)」")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(ImmortalTheme.jade)
            }

            Rectangle()
                .fill(LinearGradient(colors: [ImmortalTheme.gold, .clear], startPoint: .leading, endPoint: .trailing))
                .frame(height: 1)

            Text(store.currentNode.body)
                .font(.body)
                .lineSpacing(7)
                .foregroundStyle(Color.white.opacity(0.88))
                .textSelection(.enabled)
        }
        .immortalCard(padding: 20)
        .id(store.currentNode.id)
    }

    private var choiceList: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("你的选择")
                .font(.caption.weight(.bold))
                .tracking(2)
                .foregroundStyle(.secondary)
                .padding(.leading, 4)

            ForEach(store.currentNode.choices) { choice in
                let available = store.isChoiceAvailable(choice)
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        store.choose(choice)
                    }
                } label: {
                    HStack(spacing: 14) {
                        Image(systemName: choice.symbol)
                            .font(.title3)
                            .foregroundStyle(available ? ImmortalTheme.gold : Color.gray)
                            .frame(width: 34, height: 34)
                            .background(ImmortalTheme.gold.opacity(available ? 0.12 : 0.03), in: Circle())
                        VStack(alignment: .leading, spacing: 4) {
                            Text(choice.title)
                                .font(.headline)
                                .foregroundStyle(available ? Color.white : Color.gray)
                            Text(choice.subtitle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption.bold())
                            .foregroundStyle(available ? ImmortalTheme.gold : Color.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .immortalCard(padding: 14)
                }
                .buttonStyle(.plain)
                .disabled(!available)
            }
        }
    }

    private var endingActions: some View {
        VStack(spacing: 12) {
            Label("传奇已达成", systemImage: "crown.fill")
                .font(.title3.bold())
                .foregroundStyle(ImmortalTheme.gold)
            Text("可开启二周目，继承部分爽点与天阙黑卡，重新体验其他选择和结局。")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button {
                store.restart(newGamePlus: true)
            } label: {
                Label("开启二周目", systemImage: "arrow.clockwise.circle.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(ImmortalTheme.gold, in: RoundedRectangle(cornerRadius: 14))
                    .foregroundStyle(ImmortalTheme.ink)
            }
        }
        .immortalCard()
    }
}
