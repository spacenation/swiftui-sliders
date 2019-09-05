import SwiftUI

public protocol SliderStyle {
    var height: CGFloat { get set }
    var width: CGFloat { get set }
    var thickness: CGFloat { get set }
    
    var thumbSize: CGSize { get set }
    var thumbColor: Color { get set }
    var thumbBorderColor: Color { get set }
    var thumbBorderWidth: CGFloat { get set }
    var thumbShadowColor: Color { get set }
    var thumbShadowRadius: CGFloat { get set }
    var thumbShadowX: CGFloat { get set }
    var thumbShadowY: CGFloat { get set }
    
    var valueColor: Color { get set }
    
    var trackColor: Color { get set }
    var trackBorderColor: Color { get set }
    var trackBorderWidth: CGFloat { get set }
}

public struct SliderStyleKey: EnvironmentKey {
    public static let defaultValue: SliderStyle = CustomSliderStyle()
}

public extension EnvironmentValues {
    var sliderStyle: SliderStyle {
        get {
            return self[SliderStyleKey.self]
        }
        set {
            self[SliderStyleKey.self] = newValue
        }
    }
}

extension View {
    /// Sets the style for `Slider` within the environment of `self`.
    public func sliderStyle<S>(_ style: S) -> some View where S : SliderStyle {
        self.environment(\.sliderStyle, style)
    }
}
