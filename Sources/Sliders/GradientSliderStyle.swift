import SwiftUI

public struct GradientSliderStyle: SliderStyle {
    public var height: CGFloat = 44
    public var thickness: CGFloat = 3
    
    public var knobSize: CGSize = CGSize(width: 27, height: 27)
    public var knobColor: Color = .white
    public var knobCornerRadius: CGFloat = 13.5
    public var knobBorderColor: Color = .clear
    public var knobBorderWidth: CGFloat = 0
    public var knobShadowColor: Color = Color.black.opacity(0.3)
    public var knobShadowRadius: CGFloat = 2
    public var knobShadowX: CGFloat = 0
    public var knobShadowY: CGFloat = 1.5
    
    public var valueColor: Color = .blue
    
    public var trackColor: Color = Color.secondary.opacity(0.25)
    public var trackCornerRadius: CGFloat? = nil
    public var trackBorderColor: Color = .clear
    public var trackBorderWidth: CGFloat = 0

    public var clippedValue: Bool = true
        
    public init(gradient: LinearGradient = .init(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)) {
        self.valueView = AnyView(gradient)
    }
    
    public init(colors: [Color]) {
        self.valueView = AnyView(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
    }
    
    public var knobView: AnyView = AnyView(Rectangle())
    public var valueView: AnyView
    public var trackView: AnyView = AnyView(Rectangle())
}
