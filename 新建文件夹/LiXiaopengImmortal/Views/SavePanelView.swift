import SwiftUI

struct SavePanelView: View {
    @EnvironmentObject private var store: GameStore
    @Environment(\.dismiss) private var dismiss
    @State private var confirmReset = false

    var body: some View {
        NavigationStack {
            ZStack {
                ImmortalBackground()
                ScrollView {
                    VStack(spacing: 14) {
                        HStack(spacing: 10) {
                            Image(systemName: "icloud.and.arrow.down.fill")
                                .foregroundStyle(ImmortalTheme.jade)
                            Text("剧情选择后会自动保存，下面还可保留三个独立进度。")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .immortalCard(padding: 13)

                        ForEach(0..<3, id: \.self) { index in
                            slotCard(index)
                        }

                        Button(role: .destructive) {
                            confirmReset = true
                        } label: {
                            Label("重新开始", systemImage: "arrow.counterclockwise")
                                .font(.subheadline.weight(.semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.red.opacity(0.1), in: RoundedRectangle(cornerRadius: 14))
                        }
                    }
                    .padding(16)
                }
            }
            .navigationTitle("存档管理")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("完成") { dismiss() }
                }
            }
            .alert("确定重新开始？", isPresented: $confirmReset) {
                Button("取消", role: .cancel) {}
                Button("重新开始", role: .destructive) {
                    store.restart()
                    dismiss()
                }
            } message: {
                Text("自动存档会被重置，三个手动存档不会删除。")
            }
        }
    }

    private func slotCard(_ index: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("存档 \(index + 1)")
                    .font(.headline)
                Spacer()
                if let slot = store.saveSlots[index] {
                    Text(slot.savedAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }

            if let slot = store.saveSlots[index] {
                Text(slot.label)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(ImmortalTheme.gold)
                HStack(spacing: 10) {
                    actionButton("读取", symbol: "arrow.up.doc.fill", color: ImmortalTheme.jade) {
                        store.load(from: index)
                    }
                    actionButton("覆盖", symbol: "square.and.arrow.down.fill", color: ImmortalTheme.gold) {
                        store.save(to: index)
                    }
                    Button(role: .destructive) {
                        store.deleteSlot(index)
                    } label: {
                        Image(systemName: "trash.fill")
                            .frame(width: 38, height: 38)
                            .background(Color.red.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
                    }
                }
            } else {
                Text("空存档")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                actionButton("保存当前进度", symbol: "square.and.arrow.down.fill", color: ImmortalTheme.gold) {
                    store.save(to: index)
                }
            }
        }
        .immortalCard()
    }

    private func actionButton(_ title: String, symbol: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Label(title, systemImage: symbol)
                .font(.caption.weight(.bold))
                .foregroundStyle(color)
                .frame(maxWidth: .infinity)
                .frame(height: 38)
                .background(color.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}
