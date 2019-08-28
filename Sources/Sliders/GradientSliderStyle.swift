import SwiftUI

public struct GradientSliderStyle: SliderStyle {
    public var knobSize: CGSize = CGSize(width: 27, height: 27)
    public var knobCornerRadius: CGFloat = 13.5
    public var trackCornerRadius: CGFloat? = nil
    public var thickness: CGFloat = 3
    public var height: CGFloat = 44
    public var clippedValue: Bool = true
    
    private let gradient: LinearGradient
    
    public init(gradient: LinearGradient = .init(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)) {
        self.gradient = gradient
    }
    
    public init(colors: [Color]) {
        self.gradient = LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
    }

    public var valueView: AnyView {
        AnyView(gradient)
    }
}
