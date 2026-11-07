import SwiftUI

struct RelationsView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        NavigationStack {
            ZStack {
                ImmortalBackground()
                ScrollView {
                    VStack(spacing: 14) {
                        SectionTitle(eyebrow: "Bonds", title: "红颜知己")
                            .padding(.horizontal, 4)

                        Text("所有角色均为成年人。羁绊来自尊重、信任与共同选择。")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 4)

                        ForEach(store.state.relationships) { relationship in
                            relationCard(relationship)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("红颜羁绊")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func relationCard(_ relationship: Relationship) -> some View {
        Group {
            if relationship.unlocked {
                VStack(alignment: .leading, spacing: 13) {
                    HStack(spacing: 13) {
                        ZStack {
                            Circle()
                                .fill(ImmortalTheme.rose.opacity(0.14))
                                .frame(width: 52, height: 52)
                            Image(systemName: relationship.symbol)
                                .font(.title2)
                                .foregroundStyle(ImmortalTheme.rose)
                        }
                        VStack(alignment: .leading, spacing: 3) {
                            Text(relationship.name)
                                .font(.title3.bold())
                            Text("\(relationship.age)岁 · \(relationship.title)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 2) {
                            Text(relationship.stage)
                                .font(.caption.weight(.bold))
                                .foregroundStyle(ImmortalTheme.rose)
                            Text("\(relationship.affection)")
                                .font(.title2.monospacedDigit().bold())
                        }
                    }

                    ProgressView(value: Double(relationship.affection), total: 100)
                        .tint(ImmortalTheme.rose)

                    Label(relationship.lastMemory, systemImage: "heart.text.square")
                        .font(.footnote)
                        .foregroundStyle(Color.white.opacity(0.75))
                }
                .immortalCard()
            } else {
                HStack(spacing: 14) {
                    Image(systemName: "person.crop.circle.badge.questionmark")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    VStack(alignment: .leading, spacing: 4) {
                        Text("尚未相遇")
                            .font(.headline)
                        Text("继续推进主线，命运自会安排相逢。")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image(systemName: "lock.fill")
                        .foregroundStyle(.secondary)
                }
                .immortalCard()
            }
        }
    }
}

