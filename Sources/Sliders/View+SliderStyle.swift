import SwiftUI

extension View {
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
