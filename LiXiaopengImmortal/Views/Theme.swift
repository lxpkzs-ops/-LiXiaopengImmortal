import SwiftUI

enum ImmortalTheme {
    static let gold = Color(red: 0.93, green: 0.72, blue: 0.27)
    static let deepGold = Color(red: 0.64, green: 0.40, blue: 0.10)
    static let ink = Color(red: 0.035, green: 0.045, blue: 0.075)
    static let panel = Color(red: 0.075, green: 0.09, blue: 0.14)
    static let panelLight = Color(red: 0.11, green: 0.13, blue: 0.20)
    static let jade = Color(red: 0.24, green: 0.78, blue: 0.62)
    static let rose = Color(red: 0.94, green: 0.35, blue: 0.48)
}

struct ImmortalBackground: View {
    var body: some View {
        ZStack {
            ImmortalTheme.ink.ignoresSafeArea()
            RadialGradient(
                colors: [ImmortalTheme.deepGold.opacity(0.20), .clear],
                center: .topTrailing,
                startRadius: 10,
                endRadius: 420
            )
            .ignoresSafeArea()
            RadialGradient(
                colors: [Color.indigo.opacity(0.18), .clear],
                center: .bottomLeading,
                startRadius: 20,
                endRadius: 360
            )
            .ignoresSafeArea()
        }
    }
}

struct CardStyle: ViewModifier {
    var padding: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(ImmortalTheme.panel.opacity(0.94))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color.white.opacity(0.07), lineWidth: 1)
                    )
            )
    }
}

extension View {
    func immortalCard(padding: CGFloat = 16) -> some View {
        modifier(CardStyle(padding: padding))
    }
}

struct SectionTitle: View {
    let eyebrow: String
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(eyebrow.uppercased())
                .font(.caption.weight(.bold))
                .tracking(2)
                .foregroundStyle(ImmortalTheme.gold)
            Text(title)
                .font(.title2.bold())
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

