import Foundation
import SwiftUI

@inlinable func valueFrom(relativeValue: CGFloat, bounds: ClosedRange<CGFloat>, step: CGFloat) -> CGFloat {
    let newValue = bounds.lowerBound + (relativeValue * (bounds.upperBound - bounds.lowerBound))
    let steppedNewValue = round(newValue / step) * step
    let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
    return validatedValue
}
