import SwiftUI

public struct PlainSliderStyle: SliderStyle {
    public var height: CGFloat = 44
    public var thickness: CGFloat = 3
    
    public var thumbSize: CGSize = CGSize(width: 27, height: 27)
    public var thumbColor: Color
    public var thumbBorderColor: Color = .clear
    public var thumbBorderWidth: CGFloat = 0
    public var thumbShadowColor: Color = .clear
    public var thumbShadowRadius: CGFloat = 0
    public var thumbShadowX: CGFloat = 0
    public var thumbShadowY: CGFloat = 0
    
    public var valueColor: Color
    
    public var trackColor: Color
    public var trackBorderColor: Color = .clear
    public var trackBorderWidth: CGFloat = 0

    public var clippedValue: Bool = true
    
    public init(valueColor: Color = .accentColor, trackColor: Color = Color.secondary.opacity(0.25)) {
        self.valueColor = valueColor
        self.thumbColor = valueColor
        self.trackColor = trackColor
    }
}
