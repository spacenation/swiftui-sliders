import Foundation
import SwiftUI

public struct SliderGestureState: Equatable {
    private var lastOffset: CGFloat
    private var accumulations: [Float:CGFloat] = [1: 0]

    var offset: CGFloat {
        accumulations.reduce(0) { accum, tuple in
            let (speed, value) = tuple
            return accum + value / CGFloat(speed)
        }
    }

    init(initialOffset: CGFloat) {
        self.lastOffset = initialOffset
    }

    func updating(with offset: CGFloat, speed: Float) -> Self {
        var mutSelf = self

        var accumulations = self.accumulations.reduce([:]) { (accum: [Float:CGFloat], element) in
            let (elementSpeed, elementValue) = element

            var out = accum

            let appliedSpeed = min(elementSpeed, speed)
            out[appliedSpeed] = (out[appliedSpeed] ?? 0) + elementValue

            return out
        }
        accumulations[speed] = (accumulations[speed] ?? 0) + offset - lastOffset
        mutSelf.accumulations = accumulations

        mutSelf.lastOffset = offset

        return mutSelf
    }
}
