import SwiftUI

extension View {
    public func height(_ length: CGFloat) -> some View {
        self.environment(\.sliderStyle.height, length)
    }
    
    public func trackCornerRadius(_ length: CGFloat?) -> some View {
        self.environment(\.sliderStyle.trackCornerRadius, length)
    }
    
    public func knobSize(_ size: CGSize) -> some View {
        self.environment(\.sliderStyle.knobSize, size)
    }
    
    public func knobCornerRadius(_ radius: CGFloat) -> some View {
        self.environment(\.sliderStyle.knobCornerRadius, radius)
    }
    
    public func thickness(_ length: CGFloat) -> some View {
        self.environment(\.sliderStyle.thickness, length)
    }
    
    public func clippedValue(_ isClipped: Bool = true) -> some View {
        self.environment(\.sliderStyle.clippedValue, isClipped)
    }
}
