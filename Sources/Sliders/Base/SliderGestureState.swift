import Foundation
import SwiftUI

public struct SliderGestureState: Equatable {
    enum Speed: Float {
        case normal = 1
        case half = 2
        case quarter = 4
        case eighth = 8
    }

    let precisionScrubbing: Bool
    var speed = Speed.normal

    private var lastOffset: CGFloat
    private var accumulations: [Speed:CGFloat] = [
        .normal: 0
    ]

    var offset: CGFloat {
        accumulations.reduce(0) { accum, tuple in
            let (speed, value) = tuple
            let appliedValue = precisionScrubbing ? value / CGFloat(speed.rawValue) : value
            return accum + appliedValue
        }
    }

    init(precisionScrubbing: Bool, initialOffset: CGFloat) {
        self.precisionScrubbing = precisionScrubbing
        self.lastOffset = initialOffset
    }

    private func speed(crossAxisOffset: CGFloat) -> Speed {
        if abs(crossAxisOffset) > 300 {
            return .eighth
        } else if abs(crossAxisOffset) > 200 {
            return .quarter
        } else if abs(crossAxisOffset) > 100 {
            return .half
        } else {
            return .normal
        }
    }

    func updating(with offset: CGFloat, crossAxisOffset: CGFloat) -> Self {
        var mutSelf = self
        let speed = speed(crossAxisOffset: crossAxisOffset)
        mutSelf.speed = speed
        mutSelf.accumulations[speed] = (accumulations[speed] ?? 0) + offset - lastOffset
        mutSelf.lastOffset = offset
        return mutSelf
    }
}
