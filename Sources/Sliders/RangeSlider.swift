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
                                
                self.style.valueView
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
                    .offset(x: self.xForLowerBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let relativeValue: CGFloat = value.location.x / (geometry.size.width - self.style.knobSize.width * 2)
                                let newLowerBound = V(CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound)))
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
                    .offset(x: self.style.knobSize.width + self.xForUpperBound(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let relativeValue: CGFloat = (value.location.x - self.style.knobSize.width) / (geometry.size.width - self.style.knobSize.width * 2)
                                let newUpperBound = V(CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound)))
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
        let halfWidth = ((overallWidth - self.style.knobSize.width * 2) / 2)
        return (xForLowerBound(width: overallWidth) - halfWidth) + valueWidth(overallWidth: overallWidth) / 2
    }
    
    func valueWidth(overallWidth: CGFloat) -> CGFloat {
        xForUpperBound(width: overallWidth) - xForLowerBound(width: overallWidth)
    }
    
    func xForLowerBound(width: CGFloat) -> CGFloat {
        (width - self.style.knobSize.width * 2) * (CGFloat(self.range.wrappedValue.lowerBound - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
    
    func xForUpperBound(width: CGFloat) -> CGFloat {
        (width - self.style.knobSize.width * 2) * (CGFloat(self.range.wrappedValue.upperBound - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

#if DEBUG

struct RangeSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        RangeSlider(range: .constant(0...1))
    }
}
#endif
