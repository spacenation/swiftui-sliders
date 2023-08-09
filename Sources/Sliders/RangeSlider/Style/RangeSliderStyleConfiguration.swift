import SwiftUI

public struct RangeSliderStyleConfiguration {
    public let range: Binding<ClosedRange<CGFloat>>
    public let bounds: ClosedRange<CGFloat>
    public let step: CGFloat
    public let distance: ClosedRange<CGFloat>
    public let onEditingChanged: (Bool) -> Void
    public var precisionScrubbing: (Float) -> Float
    public var dragOffset: Binding<CGFloat?>
    public var lowerGestureState: GestureState<SliderGestureState?>
    public var upperGestureState: GestureState<SliderGestureState?>
    
    func with(precisionScrubbing: @escaping (Float) -> Float, dragOffset: Binding<CGFloat?>, lowerGestureState: GestureState<SliderGestureState?>, upperGestureState: GestureState<SliderGestureState?>) -> Self {
        var mutSelf = self
        mutSelf.precisionScrubbing = precisionScrubbing
        mutSelf.dragOffset = dragOffset
        mutSelf.lowerGestureState = lowerGestureState
        mutSelf.upperGestureState = upperGestureState
        return mutSelf
    }
}
