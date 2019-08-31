import SwiftUI

public struct ValueSlider<V, TrackView: InsettableShape, ValueView: View, ThumbView : InsettableShape>: View, SliderBase where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle)
    var style
    
    @usableFromInline
    var preferences = SliderPreferences()
    
    let value: Binding<V>
    let bounds: ClosedRange<V>
    let step: V.Stride

    let trackView: TrackView
    let valueView: ValueView
    let thumbView: ThumbView
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffsetX: CGFloat? = nil
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
                self.generatedValueTrackView(geometry: geometry, valueView: self.valueView, trackView: self.trackView)

                self.generatedThumbView(view: self.thumbView)
                    .offset(x: self.xForValue(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = value.startLocation.x - self.xForValue(width: geometry.size.width)
                                }
                                let relativeValue: CGFloat = (value.location.x - (self.dragOffsetX ?? 0)) / (geometry.size.width - self.thumbSize.width)
                                let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                                let computedValue = self.valueFrom(relativeValue: relativeValue, bounds: bounds, step: CGFloat(self.step))
                                self.value.wrappedValue = V(computedValue)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )
            }
            .frame(height: self.height)
        }
        .frame(height: self.height)
        
        /// Enabling this draws incorrect gradient on value change, fix it before enabling metal randering
        //.drawingGroup()
    }
    
    func valueOffset(overallWidth: CGFloat) -> CGFloat {
        return (xForValue(width: overallWidth) - overallWidth) / 2
    }
    
    func valueWidth(overallWidth: CGFloat) -> CGFloat {
        self.xForValue(width: overallWidth)
    }
    
    func xForValue(width: CGFloat) -> CGFloat {
        (width - self.thumbSize.width) * (CGFloat(self.value.wrappedValue - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

#if DEBUG
struct ValueSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        ValueSlider(value: .constant(0.5), thumbView: Rectangle())
            .height(100)
            .thumbColor(.blue)
            .thumbBorderWidth(4)
            .thumbBorderColor(.red)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif
