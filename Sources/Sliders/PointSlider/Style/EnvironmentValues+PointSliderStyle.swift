import SwiftUI

extension EnvironmentValues {
    var pointSliderStyle: AnyPointSliderStyle {
        get {
            return self[PointSliderStyleKey.self]
        }
        set {
            self[PointSliderStyleKey.self] = newValue
        }
    }
}

struct PointSliderStyleKey: EnvironmentKey {
    static let defaultValue: AnyPointSliderStyle = AnyPointSliderStyle(
        RectangularPointSliderStyle()
    )
}

extension View {
    /// Sets the style for `PointSlider` within the environment of `self`.
    public func pointSliderStyle<S>(_ style: S) -> some View where S : PointSliderStyle {
        self.environment(\.pointSliderStyle, AnyPointSliderStyle(style))
    }
}
