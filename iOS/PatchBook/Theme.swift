import SwiftUI

/// Patch Book's unique visual identity - a palette and mood distinct from every
/// sibling app in this portfolio, tuned to the patch domain.
enum AppTheme {
    static let background = Color(red: 0.078, green: 0.067, blue: 0.063)
    static let card = Color(red: 0.125, green: 0.102, blue: 0.090)
    static let accent = Color(red: 0.788, green: 0.486, blue: 0.180)
    static let secondary = Color(red: 0.306, green: 0.549, blue: 0.510)
    static let primaryText = Color(red: 0.953, green: 0.925, blue: 0.894)
    static let mutedText = Color(red: 0.953, green: 0.925, blue: 0.894).opacity(0.6)

    static let titleFont: Font = .system(.title2, design: .serif).weight(.bold)
    static let headlineFont: Font = .system(.headline, design: .rounded)
    static let bodyFont: Font = .system(.body, design: .rounded)
    static let captionFont: Font = .system(.caption, design: .monospaced)

    static let cornerRadius: CGFloat = 16
}

struct CardBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(AppTheme.card)
            .cornerRadius(AppTheme.cornerRadius)
    }
}

extension View {
    func cardStyle() -> some View { modifier(CardBackground()) }
}
