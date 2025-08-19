import SwiftUI

public extension EnvironmentValues {
    var valueSliderStyle: AnyValueSliderStyle {
        get {
            return self[ValueSliderStyleKey.self]
        }
        set {
            self[ValueSliderStyleKey.self] = newValue
        }
    }
}

@MainActor
struct ValueSliderStyleKey: @preconcurrency EnvironmentKey {
    static let defaultValue: AnyValueSliderStyle = AnyValueSliderStyle(
        HorizontalValueSliderStyle()
    )
}

public extension View {
    /// Sets the style for `ValueSlider` within the environment of `self`.
    @inlinable func valueSliderStyle<S>(_ style: S) -> some View where S : ValueSliderStyle {
        self.environment(\.valueSliderStyle, AnyValueSliderStyle(style))
    }
}
