import SwiftUI

public extension EnvironmentValues {
    var rangeSliderStyle: AnyRangeSliderStyle {
        get {
            return self[RangeSliderStyleKey.self]
        }
        set {
            self[RangeSliderStyleKey.self] = newValue
        }
    }
}

struct RangeSliderStyleKey: EnvironmentKey {
    static let defaultValue: AnyRangeSliderStyle = AnyRangeSliderStyle(
        HorizontalRangeSliderStyle()
    )
}

public extension View {
    /// Sets the style for `RangeSlider` within the environment of `self`.
    @inlinable func rangeSliderStyle<S>(_ style: S) -> some View where S : RangeSliderStyle {
        self.environment(\.rangeSliderStyle, AnyRangeSliderStyle(style))
    }
}
