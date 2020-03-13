import SwiftUI

extension EnvironmentValues {
    var valueSliderStyle: AnyValueSliderStyle {
        get {
            return self[ValueSliderStyleKey.self]
        }
        set {
            self[ValueSliderStyleKey.self] = newValue
        }
    }
}

struct ValueSliderStyleKey: EnvironmentKey {
    static let defaultValue: AnyValueSliderStyle = AnyValueSliderStyle(
        HorizontalValueSliderStyle()
    )
}

extension View {
    /// Sets the style for `ValueSlider` within the environment of `self`.
    public func valueSliderStyle<S>(_ style: S) -> some View where S : ValueSliderStyle {
        self.environment(\.valueSliderStyle, AnyValueSliderStyle(style))
    }
}
