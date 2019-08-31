import SwiftUI

public struct RangeSlider<V, TrackView: InsettableShape, ValueView: View, ThumbView : InsettableShape>: View, SliderBase where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle)
    var style
    
    @usableFromInline
    var preferences = SliderPreferences()
    
    let range: Binding<ClosedRange<V>>
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
                    .offset(x: self.xForLowerBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = value.startLocation.x - self.xForLowerBound(width: geometry.size.width)
                                }
                                let relativeValue: CGFloat = (value.location.x - (self.dragOffsetX ?? 0)) / (geometry.size.width - self.thumbSize.width * 2)
                                let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                                let computedLowerBound = self.valueFrom(relativeValue: relativeValue, bounds: bounds, step: CGFloat(self.step))
                                let computedUpperBound = max(computedLowerBound, CGFloat(self.range.wrappedValue.upperBound))
                                self.range.wrappedValue = (V(computedLowerBound)...V(computedUpperBound)).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )

                self.generatedThumbView(view: self.thumbView)
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .rotationEffect(Angle(degrees: 180))
                    .offset(x: self.thumbSize.width + self.xForUpperBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = self.thumbSize.width - (value.startLocation.x - self.xForUpperBound(width: geometry.size.width))
                                }
                                let relativeValue: CGFloat = ((value.location.x - self.thumbSize.width) + (self.dragOffsetX ?? 0)) / (geometry.size.width - self.thumbSize.width * 2)
                                let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                                let computedUpperBound = self.valueFrom(relativeValue: relativeValue, bounds: bounds, step: CGFloat(self.step))
                                let computedLowerBound = min(computedUpperBound, CGFloat(self.range.wrappedValue.lowerBound))
                                self.range.wrappedValue = (V(computedLowerBound)...V(computedUpperBound)).clamped(to: self.bounds)
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
        
        /// Enabling this draws incorrect gradient in value, fix it before enabling metal randering
        //.drawingGroup()
    }
    
    func valueOffset(overallWidth: CGFloat) -> CGFloat {
        let halfWidth = ((overallWidth - self.thumbSize.width * 2) / 2)
        return (xForLowerBound(width: overallWidth) - halfWidth) + valueWidth(overallWidth: overallWidth) / 2
    }
    
    func valueWidth(overallWidth: CGFloat) -> CGFloat {
        xForUpperBound(width: overallWidth) - xForLowerBound(width: overallWidth)
    }
    
    func xForLowerBound(width: CGFloat) -> CGFloat {
        xFor(value: CGFloat(self.range.wrappedValue.lowerBound), width: width)
    }
    
    func xForUpperBound(width: CGFloat) -> CGFloat {
        xFor(value: CGFloat(self.range.wrappedValue.upperBound), width: width)
    }
    
    func xFor(value: CGFloat, width: CGFloat) -> CGFloat {
        (width - self.thumbSize.width * 2) * ((value - CGFloat(bounds.lowerBound)) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

#if DEBUG

struct RangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        RangeSlider(range: .constant(0...1))
    }
}

#endif
