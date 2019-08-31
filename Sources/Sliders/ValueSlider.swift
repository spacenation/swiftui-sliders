import SwiftUI

public struct ValueSlider<V, TrackView: InsettableShape, ValueView: View, ThumbView : InsettableShape>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle) var sliderStyle
    
    let value: Binding<V>
    let bounds: ClosedRange<V>
    let step: V.Stride

    let trackView: TrackView
    let valueView: ValueView
    let thumbView: ThumbView
    
    let onEditingChanged: (Bool) -> Void
    
    @usableFromInline
    var preferredHeight: CGFloat? = nil
    
    @usableFromInline
    var preferredThickness: CGFloat? = nil
    
    @usableFromInline
    var preferredThumbSize: CGSize? = nil
        
    @usableFromInline
    var preferredThumbColor: Color? = nil
        
    @usableFromInline
    var preferredThumbBorderColor: Color? = nil
    
    @usableFromInline
    var preferredThumbBorderWidth: CGFloat? = nil
    
    @usableFromInline
    var preferredThumbShadowColor: Color? = nil
    
    @usableFromInline
    var preferredThumbShadowRadius: CGFloat? = nil
    
    @usableFromInline
    var preferredThumbShadowX: CGFloat? = nil
    
    @usableFromInline
    var preferredThumbShadowY: CGFloat? = nil
    
    @usableFromInline
    var preferredValueColor: Color? = nil
    
    @usableFromInline
    var preferredTrackColor: Color? = nil
    
    @usableFromInline
    var preferredTrackBorderColor: Color? = nil
    
    @usableFromInline
    var preferredTrackBorderWidth: CGFloat? = nil
    
    @usableFromInline
    var preferClippedValue: Bool? = nil
    
    @State
    private var dragOffsetX: CGFloat? = nil
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
                self.valueView
                    .foregroundColor(self.valueColor)
                    .frame(width: geometry.size.width, height: self.thickness)
                    .mask(
                        Rectangle()
                            .frame(
                                width: self.clippedValue ? (self.xForValue(width: geometry.size.width) + self.thumbSize.width) : geometry.size.width,
                                height: self.thickness
                            )
                            .fixedSize()
                            .offset(x: self.clippedValue ? self.maskOffset(overallWidth: geometry.size.width) : 0)
                    )
                    .overlay(
                        self.trackView
                            .strokeBorder(self.trackBorderColor, lineWidth: self.trackBorderWidth)
                    )
                    .background(self.trackColor)
                        .mask(
                            self.trackView.frame(width: geometry.size.width, height: self.thickness)
                    )

                self.thumbView
                    .overlay(
                        self.thumbView
                            .strokeBorder(self.thumbBorderColor, lineWidth: self.thumbBorderWidth)
                    )
                    .frame(width: self.thumbSize.width, height:self.thumbSize.height)
                    //.cornerRadius(self.thumbCornerRadius)
                    .foregroundColor(self.thumbColor)

                    .shadow(color:self.thumbShadowColor, radius: self.thumbShadowRadius, x: self.thumbShadowX, y: self.thumbShadowY)
                    .offset(x: self.xForValue(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = value.startLocation.x - self.xForValue(width: geometry.size.width)
                                }
                                let relativeValue: CGFloat = (value.location.x - (self.dragOffsetX ?? 0)) / (geometry.size.width - self.thumbSize.width)
                                let newValue = CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound))
                                let steppedNewValue = round(newValue / CGFloat(self.step)) * CGFloat(self.step)
                                let validatedValue = min(CGFloat(self.bounds.upperBound), max(CGFloat(self.bounds.lowerBound), steppedNewValue))
                                self.value.wrappedValue = V(validatedValue)
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
    
    func maskOffset(overallWidth: CGFloat) -> CGFloat {
        return (xForValue(width: overallWidth) - overallWidth) / 2
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
