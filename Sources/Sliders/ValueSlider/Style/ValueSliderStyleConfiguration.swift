import SwiftUI

public struct ValueSliderStyleConfiguration {
    public let value: Binding<CGFloat>
    public let bounds: ClosedRange<CGFloat>
    public let step: CGFloat
    public let onEditingChanged: (Bool) -> Void
    public var dragOffset: Binding<CGFloat?>

    public init(value: Binding<CGFloat>, bounds: ClosedRange<CGFloat>, step: CGFloat, onEditingChanged: @escaping (Bool) -> Void, dragOffset: Binding<CGFloat?>) {
        self.value = value
        self.bounds = bounds
        self.step = step
        self.onEditingChanged = onEditingChanged
        self.dragOffset = dragOffset
    }
    
    func with(dragOffset: Binding<CGFloat?>) -> Self {
        var mutSelf = self
        mutSelf.dragOffset = dragOffset
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
