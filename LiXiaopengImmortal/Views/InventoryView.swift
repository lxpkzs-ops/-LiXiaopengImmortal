import SwiftUI

struct InventoryView: View {
    @EnvironmentObject private var store: GameStore

    var body: some View {
        NavigationStack {
            ZStack {
                ImmortalBackground()
                ScrollView {
                    VStack(spacing: 14) {
                        HStack {
                            SectionTitle(eyebrow: "Treasures", title: "乾坤袋")
                            Text("\(store.visibleInventory.count) 件")
                                .font(.caption.weight(.bold))
                                .foregroundStyle(ImmortalTheme.gold)
                        }

                        ForEach(store.visibleInventory) { item in
                            itemCard(item)
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("背包")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func itemCard(_ item: InventoryItem) -> some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(rarityColor(item.rarity).opacity(0.13))
                    .frame(width: 54, height: 54)
                Image(systemName: item.symbol)
                    .font(.title2)
                    .foregroundStyle(rarityColor(item.rarity))
            }
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(item.name)
                        .font(.headline)
                    Text(item.rarity)
                        .font(.caption2.weight(.bold))
                        .foregroundStyle(rarityColor(item.rarity))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(rarityColor(item.rarity).opacity(0.1), in: Capsule())
                    Spacer()
                    Text("×\(item.quantity)")
                        .font(.subheadline.monospacedDigit().bold())
                }
                Text(item.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .immortalCard()
    }

    private func rarityColor(_ rarity: String) -> Color {
        switch rarity {
        case "神话": return .purple
        case "仙品": return .cyan
        case "传说": return ImmortalTheme.gold
        case "珍稀": return ImmortalTheme.jade
        case "纪念": return ImmortalTheme.rose
        default: return .gray
        }
    }
}

