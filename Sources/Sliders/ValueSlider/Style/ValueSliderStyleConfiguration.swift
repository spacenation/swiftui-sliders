import SwiftUI

public struct ValueSliderStyleConfiguration {
    public let value: Binding<CGFloat>
    public let bounds: ClosedRange<CGFloat>
    public let step: CGFloat
    public let onEditingChanged: (Bool) -> Void
    public var precisionScrubbing: PrecisionScrubbingConfig
    public var dragOffset: Binding<CGFloat?>
    public var thumbGestureState: GestureState<SliderGestureState?>
    public var trackGestureState: GestureState<SliderGestureState?>
    
    public init(
        value: Binding<CGFloat>,
        bounds: ClosedRange<CGFloat>,
        step: CGFloat,
        onEditingChanged: @escaping (Bool) -> Void,
        precisionScrubbing: PrecisionScrubbingConfig,
        dragOffset: Binding<CGFloat?>,
        thumbGestureState: GestureState<SliderGestureState?>,
        trackGestureState: GestureState<SliderGestureState?>
    ) {
        self.value = value
        self.bounds = bounds
        self.step = step
        self.onEditingChanged = onEditingChanged
        self.precisionScrubbing = precisionScrubbing
        self.dragOffset = dragOffset
        self.thumbGestureState = thumbGestureState
        self.trackGestureState = trackGestureState
    }
    
    func with(
        precisionScrubbing: PrecisionScrubbingConfig,
        dragOffset: Binding<CGFloat?>,
        thumbGestureState: GestureState<SliderGestureState?>,
        trackGestureState: GestureState<SliderGestureState?>
    ) -> Self {
        var mutSelf = self
        mutSelf.precisionScrubbing = precisionScrubbing
        mutSelf.dragOffset = dragOffset
        mutSelf.thumbGestureState = thumbGestureState
        mutSelf.trackGestureState = trackGestureState
        return mutSelf
    }
}
//
//public extension ValueSliderStyleConfiguration {
//    struct Track: View {
//        let typeErasedTrack: AnyView
//
//        init<T: View>(view: T) {
//            self.typeErasedTrack = AnyView(view)
//        }
//
//        public var body: some View {
//            self.typeErasedTrack
//        }
//    }
//}
//
//public extension ValueSliderStyleConfiguration {
//    struct Thumb: View {
//        let typeErasedThumb: AnyView
//
//        init<T: View>(view: T) {
//            self.typeErasedThumb = AnyView(view)
//        }
//
//        public var body: some View {
//            self.typeErasedThumb
//        }
//    }
//}
