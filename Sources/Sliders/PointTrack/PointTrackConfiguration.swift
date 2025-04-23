import SwiftUI

@MainActor
public struct PointTrackConfiguration {
    public static let defaultConfiguration = PointTrackConfiguration()
    
    public let xBounds: ClosedRange<CGFloat>
    public let xStep: CGFloat
    public let yBounds: ClosedRange<CGFloat>
    public let yStep: CGFloat
    
    public init(xBounds: ClosedRange<CGFloat> = 0.0...1.0, xStep: CGFloat = 0, yBounds: ClosedRange<CGFloat> = 0.0...1.0, yStep: CGFloat = 0) {
        self.xBounds = xBounds
        self.xStep = xStep
        self.yBounds = yBounds
        self.yStep = yStep
    }
}
