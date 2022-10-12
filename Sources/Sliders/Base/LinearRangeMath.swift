import Foundation
import SwiftUI

/// Calculates range distance in points
@inlinable func rangeDistance(overallLength: CGFloat, range: ClosedRange<CGFloat>, bounds: ClosedRange<CGFloat> = 0.0...1.0, lowerStartOffset: CGFloat = 0, lowerEndOffset: CGFloat = 0, upperStartOffset: CGFloat = 0, upperEndOffset: CGFloat = 0) -> CGFloat {
    let offsetLowerValue = distanceFrom(value: range.lowerBound, availableDistance: overallLength, bounds: bounds, leadingOffset: lowerStartOffset, trailingOffset: lowerEndOffset)
    let offsetUpperValue = distanceFrom(value: range.upperBound, availableDistance: overallLength, bounds: bounds, leadingOffset: upperStartOffset, trailingOffset: upperEndOffset)
    return max(0, offsetUpperValue - offsetLowerValue)
}

@inlinable func rangeFrom(updatedLowerBound: CGFloat, upperBound: CGFloat, bounds: ClosedRange<CGFloat>, distance: ClosedRange<CGFloat>, forceAdjacent: Bool) -> ClosedRange<CGFloat> {
    if forceAdjacent {
        let finalLowerBound = min(updatedLowerBound, bounds.upperBound - distance.lowerBound)
        let finalUpperBound = min(min(max(updatedLowerBound + distance.lowerBound, upperBound), updatedLowerBound + distance.upperBound), bounds.upperBound)
        return finalLowerBound ... finalUpperBound
    } else {
        let finalLowerBound = min(updatedLowerBound, upperBound - distance.lowerBound)
        let finalUpperBound = min(upperBound, updatedLowerBound + distance.upperBound)
        return finalLowerBound ... finalUpperBound
    }
}

@inlinable func rangeFrom(lowerBound: CGFloat, updatedUpperBound: CGFloat, bounds: ClosedRange<CGFloat>, distance: ClosedRange<CGFloat>, forceAdjacent: Bool) -> ClosedRange<CGFloat> {
    if forceAdjacent {
        let finalLowerBound = max(max(min(lowerBound, updatedUpperBound - distance.lowerBound), updatedUpperBound - distance.upperBound), bounds.lowerBound)
        let finalUpperBound = max(updatedUpperBound, bounds.lowerBound + distance.lowerBound)
        return finalLowerBound ... finalUpperBound
    } else {
        let finalLowerBound = max(lowerBound, updatedUpperBound - distance.upperBound)
        let finalUpperBound = max(lowerBound + distance.lowerBound, updatedUpperBound)
        return finalLowerBound ... finalUpperBound
    }
}
