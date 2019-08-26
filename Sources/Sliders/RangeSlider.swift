import SwiftUI

public struct RangeSlider<V, ValueView>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint, ValueView: View {
    private var range: Binding<ClosedRange<V>>
    private let boundingRange: ClosedRange<V> = 0.0 ... 1.0
    private let thumbRadius: CGFloat = 27
    
    public init(range: Binding<ClosedRange<V>>, valueView: ValueView) {
        self.range = range
        self.valueView = valueView
    }
    
    private var trackView = DefaultTrackView()
    private var valueView: ValueView

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .init(horizontal: .leading, vertical: .center)) {
                self.trackView
                    .frame(height: 3)
                    .cornerRadius(1.5)
                                
                self.valueView
                    .frame(height: 3)
                    .cornerRadius(1.5)
                    .mask(
                        Rectangle()
                            .frame(width: self.valueWidth(overallWidth: geometry.size.width), height: 3)
                            .cornerRadius(1.5)
                            .fixedSize()
                            .offset(x: self.maskOffset(overallWidth: geometry.size.width))
                )

                Circle()
                    .foregroundColor(.white)
                    .frame(width: self.thumbRadius, height: self.thumbRadius)
                    .shadow(radius: 3)
                    .offset(x: self.xForLowerBound(width: geometry.size.width))
                    .gesture(
                        DragGesture().onChanged { value in
                            let newLowerBound = V(value.location.x / (geometry.size.width - self.thumbRadius * 2))
                            let validatedLowerBound = max(self.boundingRange.lowerBound, newLowerBound)
                            let validatedUpperBound = max(validatedLowerBound, self.range.wrappedValue.upperBound)
                            self.range.wrappedValue = (validatedLowerBound...validatedUpperBound).clamped(to: self.boundingRange)
                        }
                    )

                Circle()
                    .foregroundColor(.white)
                    .frame(width: self.thumbRadius, height: self.thumbRadius)
                    .shadow(radius: 3)
                    .offset(x: 28 + self.xForUpperBound(width: geometry.size.width))
                    .gesture(
                        DragGesture().onChanged { value in
                            let newUpperBound = V((value.location.x - self.thumbRadius) / (geometry.size.width - self.thumbRadius * 2))
                            let validatedUpperBound = min(self.boundingRange.upperBound, newUpperBound)
                            let validatedLowerBound = min(validatedUpperBound, self.range.wrappedValue.lowerBound)
                            self.range.wrappedValue = (validatedLowerBound...validatedUpperBound).clamped(to: self.boundingRange)
                        }
                    )
            }
            .frame(height: 30)
        }
        .frame(height: 30)
    }
    
    func maskOffset(overallWidth: CGFloat) -> CGFloat {
        let halfWidth = ((overallWidth - self.thumbRadius * 2) / 2)
        return (xForLowerBound(width: overallWidth) - halfWidth) + valueWidth(overallWidth: overallWidth) / 2
    }
    
    func valueWidth(overallWidth: CGFloat) -> CGFloat {
        xForUpperBound(width: overallWidth) - xForLowerBound(width: overallWidth)
    }
    
    func xForLowerBound(width: CGFloat) -> CGFloat {
        (width - self.thumbRadius * 2) * CGFloat(self.range.wrappedValue.lowerBound)
    }
    
    func xForUpperBound(width: CGFloat) -> CGFloat {
        (width - self.thumbRadius * 2) * CGFloat(self.range.wrappedValue.upperBound)
    }
}

struct DefaultTrackView: View {
    var body: some View {
        Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.secondary)
    }
}

public struct DefaultValueView: View {
    public var body: some View {
        Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.accentColor)
    }
    public init() {}
}

#if DEBUG

struct RangeSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        RangeSlider(range: .constant(0...1), valueView: DefaultValueView())
    }
}
#endif
