import SwiftUI

public struct RangeSlider<V, TrackView: InsettableShape, ValueView: View, ThumbView : InsettableShape>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle) var sliderStyle
    
    let range: Binding<ClosedRange<V>>
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
                                width: self.clippedValue ? (self.valueWidth(overallWidth: geometry.size.width) + self.thumbSize.width) : geometry.size.width,
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
                        .mask(self.trackView.frame(width: geometry.size.width, height: self.thickness))
                
                
                self.thumbView
                    .overlay(
                        self.thumbView
                            .strokeBorder(self.thumbBorderColor, lineWidth: self.thumbBorderWidth)
                    )
                    .frame(width: self.thumbSize.width, height: self.thumbSize.height)
                    .shadow(color: self.thumbShadowColor, radius: self.thumbShadowRadius, x: self.thumbShadowX, y: self.thumbShadowY)
                    //.cornerRadius(self.thumbCornerRadius)
                    .foregroundColor(self.thumbColor)
                    .offset(x: self.xForLowerBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = value.startLocation.x - self.xForLowerBound(width: geometry.size.width)
                                }
                                let relativeValue: CGFloat = (value.location.x - (self.dragOffsetX ?? 0)) / (geometry.size.width - self.thumbSize.width * 2)
                                let newLowerBound = CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound))
                                let steppedNewLowerBound = round(newLowerBound / CGFloat(self.step)) * CGFloat(self.step)
                                let validatedLowerBound = max(CGFloat(self.bounds.lowerBound), steppedNewLowerBound)
                                let validatedUpperBound = max(validatedLowerBound, CGFloat(self.range.wrappedValue.upperBound))
                                self.range.wrappedValue = (V(validatedLowerBound)...V(validatedUpperBound)).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )

                self.thumbView
                    .overlay(
                        self.thumbView
                            .strokeBorder(self.thumbBorderColor, lineWidth: self.thumbBorderWidth)
                    )
                    .frame(width: self.thumbSize.width, height: self.thumbSize.height)
                    .shadow(color: self.thumbShadowColor, radius: self.thumbShadowRadius, x: self.thumbShadowX, y: self.thumbShadowY)
                    //.cornerRadius(self.thumbCornerRadius)
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
                    .rotationEffect(Angle(degrees: 180))
                    .foregroundColor(self.thumbColor)
                    
                    .offset(x: self.thumbSize.width + self.xForUpperBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = self.thumbSize.width - (value.startLocation.x - self.xForUpperBound(width: geometry.size.width))
                                }
                                let relativeValue: CGFloat = ((value.location.x - self.thumbSize.width) + (self.dragOffsetX ?? 0)) / (geometry.size.width - self.thumbSize.width * 2)
                                let newUpperBound = CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound))
                                let steppedNewUpperBound = round(newUpperBound / CGFloat(self.step)) * CGFloat(self.step)
                                let validatedUpperBound = min(CGFloat(self.bounds.upperBound), steppedNewUpperBound)
                                let validatedLowerBound = min(validatedUpperBound, CGFloat(self.range.wrappedValue.lowerBound))
                                self.range.wrappedValue = (V(validatedLowerBound)...V(validatedUpperBound)).clamped(to: self.bounds)
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
    
    func maskOffset(overallWidth: CGFloat) -> CGFloat {
        let halfWidth = ((overallWidth - self.thumbSize.width * 2) / 2)
        return (xForLowerBound(width: overallWidth) - halfWidth) + valueWidth(overallWidth: overallWidth) / 2
    }
    
    func valueWidth(overallWidth: CGFloat) -> CGFloat {
        xForUpperBound(width: overallWidth) - xForLowerBound(width: overallWidth)
    }
    
    func xForLowerBound(width: CGFloat) -> CGFloat {
        (width - self.thumbSize.width * 2) * (CGFloat(self.range.wrappedValue.lowerBound - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
    
    func xForUpperBound(width: CGFloat) -> CGFloat {
        (width - self.thumbSize.width * 2) * (CGFloat(self.range.wrappedValue.upperBound - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

#if DEBUG

struct RangeSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        RangeSlider(range: .constant(0...1))
    }
}
#endif
