import SwiftUI

struct SliderStyleKey: EnvironmentKey {
    static let defaultValue: SliderStyle = DefaultSliderStyle()
}

extension View {

    /// Sets the style for `Slider` within the environment of `self`.
    public func sliderStyle<S>(_ style: S) -> some View where S : SliderStyle {
        self.environment(\.sliderStyle, style)
    }

}

extension EnvironmentValues {
    var sliderStyle: SliderStyle {
        get {
            return self[SliderStyleKey.self]
        }
        set {
            self[SliderStyleKey.self] = newValue
        }
    }
}
