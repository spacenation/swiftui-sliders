import SwiftUI

public struct ValueSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle) var style
    
    let value: Binding<V>
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
                                width: self.style.clippedValue ? self.xForValue(width: geometry.size.width) : geometry.size.width,
                                height: self.style.thickness
                            )
                            .fixedSize()
                            .offset(x: self.style.clippedValue ? self.maskOffset(overallWidth: geometry.size.width) : 0)
                    )

                self.style.knobView
                    .frame(width: self.style.thumbRadius, height: self.style.thumbRadius)
                    .offset(x: self.xForValue(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newLowerBound = V(value.location.x / (geometry.size.width - self.style.thumbRadius))
                                let steppedNewValue = round(newLowerBound / self.step) * self.step
                                let validatedValue = min(self.bounds.upperBound, max(self.bounds.lowerBound, steppedNewValue))
                                self.value.wrappedValue = validatedValue
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
        return (xForValue(width: overallWidth) - overallWidth) / 2
    }
    
    func xForValue(width: CGFloat) -> CGFloat {
        (width - self.style.thumbRadius) * CGFloat(self.value.wrappedValue)
    }
}

#if DEBUG

struct ValueSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        ValueSlider(value: .constant(0.5))
    }
}
#endif
