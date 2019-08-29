import SwiftUI

public struct ValueSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle) var style
    
    let value: Binding<V>
    let bounds: ClosedRange<V>
    let step: V
    let onEditingChanged: (Bool) -> Void

    @State private var dragOffsetX: CGFloat? = nil
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
                Group {
                    self.style.trackView
                        .foregroundColor(self.style.trackColor)
                        .frame(height: self.style.thickness)
                        .cornerRadius(self.style.trackCornerRadius ?? self.style.thickness / 2)

                    self.style.valueView
                        .foregroundColor(self.style.valueColor)
                        .frame(height: self.style.thickness)
                        .cornerRadius(self.style.trackCornerRadius ?? self.style.thickness / 2)
                        .mask(
                            Rectangle()
                                .frame(
                                    width: self.style.clippedValue ? (self.xForValue(width: geometry.size.width) + self.style.knobSize.width) : geometry.size.width,
                                    height: self.style.thickness
                                )
                                .fixedSize()
                                .offset(x: self.style.clippedValue ? self.maskOffset(overallWidth: geometry.size.width) : 0)
                        )
                }
                .overlay(
                    RoundedRectangle(cornerRadius: self.style.trackCornerRadius ?? self.style.thickness / 2)
                        .strokeBorder(self.style.trackBorderColor, lineWidth: self.style.trackBorderWidth)
                )

                self.style.knobView
                    .frame(width: self.style.knobSize.width, height: self.style.knobSize.height)
                    .cornerRadius(self.style.knobCornerRadius)
                    .foregroundColor(self.style.knobColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: self.style.knobCornerRadius)
                            .strokeBorder(self.style.knobBorderColor, lineWidth: self.style.knobBorderWidth)
                    )
                    .shadow(color: self.style.knobShadowColor, radius: self.style.knobShadowRadius, x: self.style.knobShadowX, y: self.style.knobShadowY)
                    .offset(x: self.xForValue(width: geometry.size.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetX == nil {
                                    self.dragOffsetX = value.startLocation.x - self.xForValue(width: geometry.size.width)
                                }
                                let relativeValue: CGFloat = (value.location.x - (self.dragOffsetX ?? 0)) / (geometry.size.width - self.style.knobSize.width)
                                let newValue = V(CGFloat(self.bounds.lowerBound) + (relativeValue * CGFloat(self.bounds.upperBound - self.bounds.lowerBound)))
                                let steppedNewValue = round(newValue / self.step) * self.step
                                let validatedValue = min(self.bounds.upperBound, max(self.bounds.lowerBound, steppedNewValue))
                                self.value.wrappedValue = validatedValue
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
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
