import SwiftUI

public protocol SliderStyle {
    var thumbRadius: CGFloat { get set }
    var thickness: CGFloat { get set }
    var height: CGFloat { get set }
    
    var knobView: AnyView { get }
    var valueView: AnyView { get }
    var trackView: AnyView { get }
    
    var clippedValue: Bool { get set }
}

extension SliderStyle {
    public var knobView: AnyView {
        AnyView(Circle()
            .foregroundColor(.white)
            .shadow(radius: 3)
        )
    }
    
    public var trackView: AnyView {
        AnyView(Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.secondary)
            .opacity(0.25)
        )
    }
}


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
