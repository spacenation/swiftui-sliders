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

                self.style.valueView
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
                    .offset(x: self.xForValue(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let relativeValue: CGFloat = value.location.x / (geometry.size.width - self.style.knobSize.width)
                                let newValue = V(CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound)))
                                let steppedNewValue = round(newValue / self.step) * self.step
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
        (width - self.style.knobSize.width) * (CGFloat(self.value.wrappedValue - bounds.lowerBound) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

#if DEBUG

struct ValueSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        ValueSlider(value: .constant(0.5))
    }
}
#endif
