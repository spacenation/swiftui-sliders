import SwiftUI

public struct RangeSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle) var style
    
    let range: Binding<ClosedRange<V>>
    let bounds: ClosedRange<V>
    let step: V
    let onEditingChanged: (Bool) -> Void

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
                self.style.trackView
                    .frame(height: self.style.thickness)
                    .cornerRadius(self.style.thickness / 2)
                                
                self.style.valueView
                    .frame(height: self.style.thickness)
                    .cornerRadius(self.style.thickness / 2)
                    .mask(
                        Rectangle()
                            .frame(
                                width: self.style.clippedValue ? self.valueWidth(overallWidth: geometry.size.width) : geometry.size.width,
                                height: self.style.thickness
                            )
                            .fixedSize()
                            .offset(x: self.style.clippedValue ? self.maskOffset(overallWidth: geometry.size.width) : 0)
                    )

                self.style.knobView
                    .frame(width: self.style.thumbRadius, height: self.style.thumbRadius)
                    .offset(x: self.xForLowerBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newLowerBound = V(value.location.x / (geometry.size.width - self.style.thumbRadius * 2))
                                let steppedNewLowerBound = round(newLowerBound / self.step) * self.step
                                let validatedLowerBound = max(self.bounds.lowerBound, steppedNewLowerBound)
                                let validatedUpperBound = max(validatedLowerBound, self.range.wrappedValue.upperBound)
                                self.range.wrappedValue = (validatedLowerBound...validatedUpperBound).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.onEditingChanged(false)
                            }
                    )

                self.style.knobView
                    .frame(width: self.style.thumbRadius, height: self.style.thumbRadius)
                    .offset(x: self.style.thumbRadius + self.xForUpperBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newUpperBound = V((value.location.x - self.style.thumbRadius) / (geometry.size.width - self.style.thumbRadius * 2))
                                let steppedNewUpperBound = round(newUpperBound / self.step) * self.step
                                let validatedUpperBound = min(self.bounds.upperBound, steppedNewUpperBound)
                                let validatedLowerBound = min(validatedUpperBound, self.range.wrappedValue.lowerBound)
                                self.range.wrappedValue = (validatedLowerBound...validatedUpperBound).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.onEditingChanged(false)
                            }
                    )
            }
            .frame(height: self.style.height)
        }
        .frame(height: self.style.height)
    }
    
    func maskOffset(overallWidth: CGFloat) -> CGFloat {
        let halfWidth = ((overallWidth - self.style.thumbRadius * 2) / 2)
        return (xForLowerBound(width: overallWidth) - halfWidth) + valueWidth(overallWidth: overallWidth) / 2
    }
    
    func valueWidth(overallWidth: CGFloat) -> CGFloat {
        xForUpperBound(width: overallWidth) - xForLowerBound(width: overallWidth)
    }
    
    func xForLowerBound(width: CGFloat) -> CGFloat {
        (width - self.style.thumbRadius * 2) * CGFloat(self.range.wrappedValue.lowerBound)
    }
    
    func xForUpperBound(width: CGFloat) -> CGFloat {
        (width - self.style.thumbRadius * 2) * CGFloat(self.range.wrappedValue.upperBound)
    }
}

#if DEBUG

struct RangeSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        RangeSlider(range: .constant(0...1))
    }
}
#endif
