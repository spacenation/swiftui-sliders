import Foundation
import SwiftUI

/// Return a relative value for value in bounds
/// Example: For value 3.0 in bounds 2.0...4.0 returns 0.5
@inlinable func relativeValueFrom(value: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0) -> CGFloat {
    let boundsLenght = bounds.upperBound - bounds.lowerBound
    return (value - bounds.lowerBound) / boundsLenght
}

/// Calculates relative position from 0.0 to 1.0 in given lenght where zero offset is in the center.
/// Example: For offset 0 in lenght 100 returns 0.5
@inlinable func relativeValueFrom(overallLength: CGFloat, centerOffset: CGFloat) -> CGFloat {
    (centerOffset + (overallLength / 2)) / overallLength
}

/// Calculates value for relative point in bounds with step.
/// Example: For relative value 0.5 in range 2.0..4.0 produces 3.0
@inlinable func valueFrom(relativeValue: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, step: CGFloat = 0.001) -> CGFloat {
    let newValue = bounds.lowerBound + (relativeValue * (bounds.upperBound - bounds.lowerBound))
    let steppedNewValue = (round(newValue / step) * step)
    let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
    return validatedValue
}

/// Calculates distance from zero in points
@inlinable func distanceFromZero(overallLength: CGFloat, value: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, startOffset: CGFloat = 0, endOffset: CGFloat = 0) -> CGFloat {
    let computedRelativeValue = relativeValueFrom(value: value, bounds: bounds)
    let offset = (startOffset - ((startOffset + endOffset) * computedRelativeValue))
    return offset + (overallLength * computedRelativeValue)
}

/// Calculates offset from center in points for value span
@inlinable func offsetFromCenterToValueDistanceCenter(overallLength: CGFloat, value: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, startOffset: CGFloat = 0, endOffset: CGFloat = 0) -> CGFloat {
    let valueLenghtWithOffset = distanceFromZero(overallLength: overallLength, value: value, bounds: bounds, startOffset: startOffset, endOffset: endOffset)
    return ((valueLenghtWithOffset - overallLength) / 2)
}


/// Available length should pass width minus slider length.
@inlinable func offsetFromCenterToValue(overallLength: CGFloat, value: CGFloat, bounds: ClosedRange<CGFloat> = 0.0...1.0, startOffset: CGFloat = 0, endOffset: CGFloat = 0) -> CGFloat {
    let computedRelativeValue = relativeValueFrom(value: value, bounds: bounds)
    let offset = (startOffset - ((startOffset + endOffset) * computedRelativeValue))
    return offset + (computedRelativeValue * overallLength) - (overallLength / 2)
}

/// Range

/// Calculates span lenght in points
@inlinable func rangeDistance(overallLength: CGFloat, range: ClosedRange<CGFloat>, bounds: ClosedRange<CGFloat> = 0.0...1.0, lowerStartOffset: CGFloat = 0, lowerEndOffset: CGFloat = 0, upperStartOffset: CGFloat = 0, upperEndOffset: CGFloat = 0) -> CGFloat {
    let offsetLowerValue = distanceFromZero(overallLength: overallLength, value: range.lowerBound, bounds: bounds, startOffset: lowerStartOffset, endOffset: lowerEndOffset)
    let offsetUpperValue = distanceFromZero(overallLength: overallLength, value: range.upperBound, bounds: bounds, startOffset: upperStartOffset, endOffset: upperEndOffset)
    return offsetUpperValue - offsetLowerValue
}

/// Calculates offset from center in points for value span
@inlinable func offsetFromCenterToRangeCenter(overallLength: CGFloat, range: ClosedRange<CGFloat>, bounds: ClosedRange<CGFloat> = 0.0...1.0, lowerStartOffset: CGFloat = 0, lowerEndOffset: CGFloat = 0, upperStartOffset: CGFloat = 0, upperEndOffset: CGFloat = 0) -> CGFloat {
    let valueLenghtWithOffset = rangeDistance(overallLength: overallLength, range: range, bounds: bounds, lowerStartOffset: lowerStartOffset, lowerEndOffset: lowerEndOffset, upperStartOffset: upperStartOffset, upperEndOffset: upperEndOffset)
    let offsetLowerValue = distanceFromZero(overallLength: overallLength, value: range.lowerBound, bounds: bounds, startOffset: lowerStartOffset, endOffset: lowerEndOffset)
    return offsetLowerValue + ((valueLenghtWithOffset - overallLength) / 2)
}
