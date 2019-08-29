import SwiftUI

public struct CustomSliderStyle: SliderStyle {
    public var height: CGFloat = 44
    public var thickness: CGFloat = 3
    
    public var knobSize: CGSize
    public var knobColor: Color
    public var knobCornerRadius: CGFloat
    public var knobBorderColor: Color
    public var knobBorderWidth: CGFloat
    public var knobShadowColor: Color
    public var knobShadowRadius: CGFloat
    public var knobShadowX: CGFloat
    public var knobShadowY: CGFloat
    
    public var valueColor: Color
    
    public var trackColor: Color
    public var trackCornerRadius: CGFloat?
    public var trackBorderColor: Color
    public var trackBorderWidth: CGFloat

    public var clippedValue: Bool
    
    public var knobView: AnyView
    public var valueView: AnyView
    public var trackView: AnyView
    
    public init(
        height: CGFloat = 44,
        thickness: CGFloat = 3,
        knobSize: CGSize = CGSize(width: 27, height: 27),
        knobColor: Color = .white,
        knobCornerRadius: CGFloat = 13.5,
        knobBorderColor: Color = .clear,
        knobBorderWidth: CGFloat = 0,
        knobShadowColor: Color = Color.black.opacity(0.3),
        knobShadowRadius: CGFloat = 2,
        knobShadowX: CGFloat = 0,
        knobShadowY: CGFloat = 1.5,
        valueColor: Color = .accentColor,
        trackColor: Color = Color.secondary.opacity(0.25),
        trackCornerRadius: CGFloat? = nil,
        trackBorderColor: Color = .clear,
        trackBorderWidth: CGFloat = 0,
        clippedValue: Bool = true,
        knobView: AnyView = AnyView(Rectangle()),
        valueView: AnyView = AnyView(Rectangle()),
        trackView: AnyView = AnyView(Rectangle())
    ) {
        self.height = height
        self.thickness = thickness
        self.knobSize = knobSize
        self.knobColor = knobColor
        self.knobCornerRadius = knobCornerRadius
        self.knobBorderColor = knobBorderColor
        self.knobBorderWidth = knobBorderWidth
        self.knobShadowColor = knobShadowColor
        self.knobShadowRadius = knobShadowRadius
        self.knobShadowX = knobShadowX
        self.knobShadowY = knobShadowY
        self.valueColor = valueColor
        self.trackColor = trackColor
        self.trackCornerRadius = trackCornerRadius
        self.trackBorderColor = trackBorderColor
        self.trackBorderWidth = trackBorderWidth
        self.clippedValue = clippedValue
        self.knobView = knobView
        self.valueView = valueView
        self.trackView = trackView
    }
}
