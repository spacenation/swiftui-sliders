import SwiftUI

extension View {
    public func clippedValue(_ isClipped: Bool = true) -> some View {
        self.environment(\.sliderStyle.clippedValue, isClipped)
    }
}
