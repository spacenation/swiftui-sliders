import Foundation
import SwiftUI

/// Linear calculations

/// Calculates distance from zero in points
@inlinable func distanceFrom(value: CGFloat, availableDistance: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) -> CGFloat {
    guard availableDistance > leadingOffset + trailingOffset else { return 0 }
    let boundsLenght = bounds.upperBound - bounds.lowerBound
    let relativeValue = (value - bounds.lowerBound) / boundsLenght
    let offset = (leadingOffset - ((leadingOffset + trailingOffset) * relativeValue))
    return offset + (availableDistance * relativeValue)
}

/// Calculates value for relative point in bounds with step.
/// Example: For relative value 0.5 in range 2.0..4.0 produces 3.0
@inlinable func valueFrom(distance: CGFloat, availableDistance: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, step: CGFloat = 0.001, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) -> CGFloat {
    let relativeValue = (distance - leadingOffset) / (availableDistance - (leadingOffset + trailingOffset))
    let newValue = bounds.lowerBound + (relativeValue * (bounds.upperBound - bounds.lowerBound))
    let steppedNewValue = (round(newValue / step) * step)
    let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
    return validatedValue
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
