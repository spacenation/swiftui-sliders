import Foundation
import SwiftUI

/// Linear calculations

/// Calculates the distance in points from the leading edge based on a value within a range.
///
/// This method computes a visual position (e.g., slider thumb) in a given layout space, taking into account offsets and layout direction.
///
/// - Parameters:
///   - value: The input value to convert to a position, typically within `bounds`.
///   - availableDistance: The total space available for the layout, excluding leading/trailing offsets.
///   - bounds: The range representing the minimum and maximum values (default is 0.0...1.0).
///   - leadingOffset: The offset at the start of the available space.
///   - trailingOffset: The offset at the end of the available space.
///   - isRightToLeft: Whether the layout should be mirrored (right-to-left).
/// - Returns: The position in points corresponding to the value.
@inlinable
func distanceFrom(
    value: CGFloat,
    availableDistance: CGFloat,
    bounds: ClosedRange<CGFloat> = 0.0...1.0,
    leadingOffset: CGFloat = 0,
    trailingOffset: CGFloat = 0,
    isRightToLeft: Bool = false
) -> CGFloat {
    guard availableDistance > leadingOffset + trailingOffset else { return 0 }

    let boundsLength = bounds.upperBound - bounds.lowerBound
    let relativeValue = (value - bounds.lowerBound) / boundsLength

    let adjustedRelativeValue = isRightToLeft ? 1.0 - relativeValue : relativeValue
    let offset = (leadingOffset - ((leadingOffset + trailingOffset) * adjustedRelativeValue))

    return offset + (availableDistance * adjustedRelativeValue)
}

/// Calculates the value corresponding to a point along a layout axis, clamped to the provided bounds and snapped to the nearest step.
///
/// This method is typically the inverse of `distanceFrom`, converting a position (e.g., user touch location) back to a value in a specified range.
///
/// - Parameters:
///   - distance: The visual position in points, such as a touch location.
///   - availableDistance: The total space available for layout.
///   - bounds: The valid value range (default is 0.0...1.0).
///   - step: The smallest allowed step size when calculating the value (default is 0.001).
///   - leadingOffset: Offset before the usable area.
///   - trailingOffset: Offset after the usable area.
///   - isRightToLeft: Whether the layout is in a right-to-left direction.
/// - Returns: The value corresponding to the given distance, clamped and stepped.
@inlinable
func valueFrom(
    distance: CGFloat,
    availableDistance: CGFloat,
    bounds: ClosedRange<CGFloat> = 0.0...1.0,
    step: CGFloat = 0.001,
    leadingOffset: CGFloat = 0,
    trailingOffset: CGFloat = 0,
    isRightToLeft: Bool = false
) -> CGFloat {
    let relativeValue = (distance - leadingOffset) / (availableDistance - (leadingOffset + trailingOffset))
    let adjustedRelativeValue = isRightToLeft ? 1.0 - relativeValue : relativeValue

    let newValue = bounds.lowerBound + (adjustedRelativeValue * (bounds.upperBound - bounds.lowerBound))
    let steppedNewValue = (round(newValue / step) * step)
    let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))

    return validatedValue
}

/// Clamps the current value to the specified closed range.
///
/// - Parameter range: The closed range to clamp the value to.
/// - Returns: The value, clamped to the given range.
extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

