import SwiftUI

public struct RangeSliderStyleConfiguration {
    public let range: Binding<ClosedRange<CGFloat>>
    public let bounds: ClosedRange<CGFloat>
    public let step: CGFloat
    public let distance: ClosedRange<CGFloat>
    public let onEditingChanged: (Bool) -> Void
    public var precisionScrubbing: PrecisionScrubbingConfig
    public var dragOffset: Binding<CGFloat?>
    public var lowerGestureState: GestureState<SliderGestureState?>
    public var upperGestureState: GestureState<SliderGestureState?>
    
    func with(precisionScrubbing: PrecisionScrubbingConfig, dragOffset: Binding<CGFloat?>, lowerGestureState: GestureState<SliderGestureState?>, upperGestureState: GestureState<SliderGestureState?>) -> Self {
        var mutSelf = self
        mutSelf.precisionScrubbing = precisionScrubbing
        mutSelf.dragOffset = dragOffset
        mutSelf.lowerGestureState = lowerGestureState
        mutSelf.upperGestureState = upperGestureState
        return mutSelf
    }
}
