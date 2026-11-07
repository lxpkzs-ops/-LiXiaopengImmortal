import SwiftUI

struct StatusView: View {
    @EnvironmentObject private var store: GameStore

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ZStack {
                ImmortalBackground()
                ScrollView {
                    VStack(spacing: 18) {
                        heroHeader
                        statsGrid
                        realmPath
                        historyCard
                    }
                    .padding(16)
                }
            }
            .navigationTitle("李晓鹏 · 道途")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var heroHeader: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(ImmortalTheme.gold.opacity(0.12))
                    .frame(width: 86, height: 86)
                Circle()
                    .stroke(ImmortalTheme.gold.opacity(0.55), lineWidth: 1)
                    .frame(width: 76, height: 76)
                Image(systemName: "figure.martial.arts")
                    .font(.system(size: 38))
                    .foregroundStyle(ImmortalTheme.gold)
            }
            Text("李晓鹏")
                .font(.title.bold())
            Text("表面：\(store.state.stats.visibleRealm)  ·  真正战力：？？？")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text("“我本想低调，可他们非要把脸凑过来。”")
                .font(.footnote.italic())
                .foregroundStyle(ImmortalTheme.gold.opacity(0.85))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .immortalCard()
    }

    private var statsGrid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            statCell("灵力", value: "\(store.state.stats.qi)", symbol: "bolt.circle.fill", color: .cyan)
            statCell("财富", value: store.formatMoney(store.state.stats.money), symbol: "yensign.circle.fill", color: ImmortalTheme.gold)
            statCell("声望", value: "\(store.state.stats.reputation)", symbol: "person.3.fill", color: ImmortalTheme.jade)
            statCell("爽点", value: "\(store.state.stats.swagger)", symbol: "flame.fill", color: .orange)
        }
    }

    private func statCell(_ title: String, value: String, symbol: String, color: Color) -> some View {
        HStack(spacing: 12) {
            Image(systemName: symbol)
                .font(.title2)
                .foregroundStyle(color)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.headline.monospacedDigit())
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
            Spacer(minLength: 0)
        }
        .immortalCard(padding: 13)
    }

    private var realmPath: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionTitle(eyebrow: "Realm", title: "境界之路")
            ForEach(Array(HeroStats.realms.enumerated()), id: \.offset) { index, realm in
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(index <= store.state.stats.realmIndex ? ImmortalTheme.gold : Color.white.opacity(0.06))
                            .frame(width: 28, height: 28)
                        Image(systemName: index < store.state.stats.realmIndex ? "checkmark" : (index == store.state.stats.realmIndex ? "sparkles" : "lock.fill"))
                            .font(.caption.bold())
                            .foregroundStyle(index <= store.state.stats.realmIndex ? ImmortalTheme.ink : Color.gray)
                    }
                    Text(realm)
                        .font(.subheadline.weight(index == store.state.stats.realmIndex ? .bold : .regular))
                        .foregroundStyle(index <= store.state.stats.realmIndex ? Color.white : Color.gray)
                    Spacer()
                    if index == store.state.stats.realmIndex {
                        Text("当前伪装")
                            .font(.caption2.weight(.bold))
                            .foregroundStyle(ImmortalTheme.gold)
                    }
                }
            }
        }
        .immortalCard()
    }

    private var historyCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(eyebrow: "Chronicle", title: "最近抉择")
            if store.state.history.isEmpty {
                Text("传奇才刚刚开始。")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(Array(store.state.history.suffix(6).reversed().enumerated()), id: \.offset) { _, entry in
                    HStack(alignment: .top, spacing: 9) {
                        Circle()
                            .fill(ImmortalTheme.gold)
                            .frame(width: 6, height: 6)
                            .padding(.top, 7)
                        Text(entry)
                            .font(.footnote)
                            .foregroundStyle(Color.white.opacity(0.82))
                    }
                }
            }
        }
        .immortalCard()
    }
}

