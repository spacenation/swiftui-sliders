import SwiftUI

extension View {
    public func thickness(_ length: CGFloat) -> some View {
        self.environment(\.sliderStyle.thickness, length)
    }
}

