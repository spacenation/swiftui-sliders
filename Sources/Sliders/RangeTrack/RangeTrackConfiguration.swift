import SwiftUI

public struct RangeTrackConfiguration {
    public static let defaultConfiguration = RangeTrackConfiguration()
    
    public let bounds: ClosedRange<CGFloat>
    
    public let lowerLeadingOffset: CGFloat
    public let lowerTrailingOffset: CGFloat
    public let upperLeadingOffset: CGFloat
    public let upperTrailingOffset: CGFloat
    
    public init(bounds: ClosedRange<CGFloat> = 0.0...1.0, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.bounds = bounds
        self.lowerLeadingOffset = lowerLeadingOffset
        self.lowerTrailingOffset = lowerTrailingOffset
        self.upperLeadingOffset = upperLeadingOffset
        self.upperTrailingOffset = upperTrailingOffset
    }
}

public extension RangeTrackConfiguration {
    init(bounds: ClosedRange<CGFloat> = 0.0...1.0, lowerOffset: CGFloat = 0, upperOffset: CGFloat = 0) {
        self.bounds = bounds
        self.lowerLeadingOffset = lowerOffset / 2
        self.lowerTrailingOffset = lowerOffset / 2 + upperOffset
        self.upperLeadingOffset = lowerOffset + upperOffset / 2
        self.upperTrailingOffset = upperOffset / 2
    }
}

public extension RangeTrackConfiguration {
    init(bounds: ClosedRange<CGFloat> = 0.0...1.0, offsets: CGFloat = 0) {
        self.bounds = bounds
        self.lowerLeadingOffset = offsets / 2
        self.lowerTrailingOffset = offsets / 2 + offsets
        self.upperLeadingOffset = offsets + offsets / 2
        self.upperTrailingOffset = offsets / 2
    }
}
