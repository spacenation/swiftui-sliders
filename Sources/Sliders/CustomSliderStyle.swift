import SwiftUI

public struct CustomSliderStyle: SliderStyle {
    public var height: CGFloat
    public var width: CGFloat
    public var thickness: CGFloat
    
    public var thumbSize: CGSize
    public var thumbColor: Color
    public var thumbBorderColor: Color
    public var thumbBorderWidth: CGFloat
    public var thumbShadowColor: Color
    public var thumbShadowRadius: CGFloat
    public var thumbShadowX: CGFloat
    public var thumbShadowY: CGFloat
    
    public var valueColor: Color
    
    public var trackColor: Color
    public var trackBorderColor: Color
    public var trackBorderWidth: CGFloat

    public var clippedValue: Bool
    
    public init(
        height: CGFloat = 44,
        width: CGFloat = 44,
        thickness: CGFloat = 3,
        thumbSize: CGSize = CGSize(width: 27, height: 27),
        thumbColor: Color = .white,
        thumbCornerRadius: CGFloat = 13.5,
        thumbBorderColor: Color = .clear,
        thumbBorderWidth: CGFloat = 0,
        thumbShadowColor: Color = Color.black.opacity(0.3),
        thumbShadowRadius: CGFloat = 2,
        thumbShadowX: CGFloat = 0,
        thumbShadowY: CGFloat = 1.5,
        valueColor: Color = .accentColor,
        trackColor: Color = Color.secondary.opacity(0.25),
        trackBorderColor: Color = .clear,
        trackBorderWidth: CGFloat = 0,
        clippedValue: Bool = true
    ) {
        self.height = height
        self.width = width
        self.thickness = thickness
        self.thumbSize = thumbSize
        self.thumbColor = thumbColor
        self.thumbBorderColor = thumbBorderColor
        self.thumbBorderWidth = thumbBorderWidth
        self.thumbShadowColor = thumbShadowColor
        self.thumbShadowRadius = thumbShadowRadius
        self.thumbShadowX = thumbShadowX
        self.thumbShadowY = thumbShadowY
        self.valueColor = valueColor
        self.trackColor = trackColor
        self.trackBorderColor = trackBorderColor
        self.trackBorderWidth = trackBorderWidth
        self.clippedValue = clippedValue
    }
}
