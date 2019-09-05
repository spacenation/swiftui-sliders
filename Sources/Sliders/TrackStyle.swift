import SwiftUI

public protocol TrackStyle {
    var valueColor: Color { get set }
    var backgroundColor: Color { get set }
    var borderColor: Color { get set }
    var borderWidth: CGFloat { get set }
    var startOffset: CGFloat { get set }
    var endOffset: CGFloat { get set }
    var lowerStartOffset: CGFloat { get set }
    var lowerEndOffset: CGFloat { get set }
    var upperStartOffset: CGFloat { get set }
    var upperEndOffset: CGFloat { get set }
}

public struct TrackStyleKey: EnvironmentKey {
    public static let defaultValue: TrackStyle = CustomTrackStyle()
}

public extension EnvironmentValues {
    var trackStyle: TrackStyle {
        get {
            return self[TrackStyleKey.self]
        }
        set {
            self[TrackStyleKey.self] = newValue
        }
    }
}

extension View {
    /// Sets the style for `Track` within the environment of `self`.
    public func trackStyle<S>(_ style: S) -> some View where S : TrackStyle {
        self.environment(\.trackStyle, style)
    }
}

public struct CustomTrackStyle: TrackStyle {
    public var valueColor: Color
    public var backgroundColor: Color
    public var borderColor: Color
    public var borderWidth: CGFloat
    public var startOffset: CGFloat
    public var endOffset: CGFloat
    public var lowerStartOffset: CGFloat
    public var lowerEndOffset: CGFloat
    public var upperStartOffset: CGFloat
    public var upperEndOffset: CGFloat
    
    public init(
        valueColor: Color = .accentColor,
        backgroundColor: Color = Color.secondary.opacity(0.25),
        borderColor: Color = .clear,
        borderWidth: CGFloat = 0,
        startOffset: CGFloat = 0,
        endOffset: CGFloat = 0,
        lowerStartOffset: CGFloat = 0,
        lowerEndOffset: CGFloat = 0,
        upperStartOffset: CGFloat = 0,
        upperEndOffset: CGFloat = 0
    ) {
        self.valueColor = valueColor
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.startOffset = startOffset
        self.endOffset = endOffset
        self.lowerStartOffset = lowerStartOffset
        self.lowerEndOffset = lowerEndOffset
        self.upperStartOffset = upperStartOffset
        self.upperEndOffset = upperEndOffset
    }
}
