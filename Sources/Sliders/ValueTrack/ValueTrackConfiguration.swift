import SwiftUI

public struct ValueTrackConfiguration {
    public static let defaultConfiguration = ValueTrackConfiguration()
    
    public let bounds: ClosedRange<CGFloat>
    public let leadingOffset: CGFloat
    public let trailingOffset: CGFloat
    
    public init(bounds: ClosedRange<CGFloat> = 0.0...1.0, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.bounds = bounds
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
    }
}

public extension ValueTrackConfiguration {
    init(bounds: ClosedRange<CGFloat> = 0.0...1.0, offsets: CGFloat = 0) {
        self.bounds = bounds
        self.leadingOffset = offsets
        self.trailingOffset = offsets
    }
}
