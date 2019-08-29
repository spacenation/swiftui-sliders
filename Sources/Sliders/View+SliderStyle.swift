import SwiftUI

extension View {
    public func height(_ length: CGFloat) -> some View {
        self.environment(\.sliderStyle.height, length)
    }
    
    public func thickness(_ length: CGFloat) -> some View {
        self.environment(\.sliderStyle.thickness, length)
    }
    
    public func knobSize(_ size: CGSize) -> some View {
        self.environment(\.sliderStyle.knobSize, size)
    }
    
    public func knobColor(_ color: Color) -> some View {
        self.environment(\.sliderStyle.knobColor, color)
    }
    
    public func knobCornerRadius(_ radius: CGFloat) -> some View {
        self.environment(\.sliderStyle.knobCornerRadius, radius)
    }
    
    public func knobBorderColor(_ color: Color) -> some View {
        self.environment(\.sliderStyle.knobBorderColor, color)
    }
    
    public func knobBorderWidth(_ length: CGFloat) -> some View {
        self.environment(\.sliderStyle.knobBorderWidth, length)
    }
    
    public func knobShadowColor(_ color: Color) -> some View {
        self.environment(\.sliderStyle.knobShadowColor, color)
    }
    
    public func knobShadowRadius(_ radius: CGFloat) -> some View {
        self.environment(\.sliderStyle.knobShadowRadius, radius)
    }
    
    public func knobShadowX(_ offset: CGFloat) -> some View {
        self.environment(\.sliderStyle.knobShadowX, offset)
    }
    
    public func knobShadowY(_ offset: CGFloat) -> some View {
        self.environment(\.sliderStyle.knobShadowY, offset)
    }
    
    public func valueColor(_ color: Color) -> some View {
        self.environment(\.sliderStyle.valueColor, color)
    }
    
    public func trackColor(_ color: Color) -> some View {
        self.environment(\.sliderStyle.trackColor, color)
    }
    
    public func trackCornerRadius(_ length: CGFloat?) -> some View {
        self.environment(\.sliderStyle.trackCornerRadius, length)
    }
    
    public func trackBorderColor(_ color: Color) -> some View {
        self.environment(\.sliderStyle.trackBorderColor, color)
    }
    
    public func trackBorderWidth(_ length: CGFloat) -> some View {
        self.environment(\.sliderStyle.trackBorderWidth, length)
    }
    
    public func clippedValue(_ isClipped: Bool = true) -> some View {
        self.environment(\.sliderStyle.clippedValue, isClipped)
    }
}
