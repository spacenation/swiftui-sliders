import Foundation
import SwiftUI

/// Linear calculations

/// Calculates distance from zero in points
@inlinable
func distanceFrom(value: CGFloat, availableDistance: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0, isRightToLeft: Bool = false) -> CGFloat {
    guard availableDistance > leadingOffset + trailingOffset else { return 0 }

    let boundsLength = bounds.upperBound - bounds.lowerBound
    let relativeValue = (value - bounds.lowerBound) / boundsLength

    let adjustedRelativeValue = isRightToLeft ? 1.0 - relativeValue : relativeValue
    let offset = (leadingOffset - ((leadingOffset + trailingOffset) * adjustedRelativeValue))

    return offset + (availableDistance * adjustedRelativeValue)
}

/// Calculates value for relative point in bounds with step.
/// Example: For relative value 0.5 in range 2.0..4.0 produces 3.0
@inlinable
func valueFrom(distance: CGFloat, availableDistance: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, step: CGFloat = 0.001, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0, isRightToLeft: Bool = false) -> CGFloat {
    let relativeValue = (distance - leadingOffset) / (availableDistance - (leadingOffset + trailingOffset))
    let adjustedRelativeValue = isRightToLeft ? 1.0 - relativeValue : relativeValue

    let newValue = bounds.lowerBound + (adjustedRelativeValue * (bounds.upperBound - bounds.lowerBound))
    let steppedNewValue = (round(newValue / step) * step)
    let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))

    return validatedValue
}

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}
