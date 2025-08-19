import SwiftUI

public extension EnvironmentValues {
    var pointSliderStyle: AnyPointSliderStyle {
        get {
            return self[PointSliderStyleKey.self]
        }
        set {
            self[PointSliderStyleKey.self] = newValue
        }
    }
}

@MainActor
struct PointSliderStyleKey: @preconcurrency EnvironmentKey {
    static let defaultValue: AnyPointSliderStyle = AnyPointSliderStyle(
        RectangularPointSliderStyle()
    )
}

public extension View {
    /// Sets the style for `PointSlider` within the environment of `self`.
    @inlinable func pointSliderStyle<S>(_ style: S) -> some View where S : PointSliderStyle {
        self.environment(\.pointSliderStyle, AnyPointSliderStyle(style))
    }
}
