import SwiftUI

public struct RangeSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    private var range: Binding<ClosedRange<V>>
    private let boundingRange: ClosedRange<V> = 0.0 ... 1.0
    private let thumbRadius: CGFloat = 27

    public init(range: Binding<ClosedRange<V>>) {
        self.range = range
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RangeSliderTrack()
//                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
//                    .frame(height: 3)
//                    .cornerRadius(1.5)

                Circle()
                    .frame(width: self.thumbRadius, height: self.thumbRadius)
                    .shadow(radius: 3)
                    .offset(x: (geometry.size.width - self.thumbRadius * 2) * CGFloat(self.range.value.lowerBound))
                    .gesture(
                        DragGesture().onChanged { value in
                            let newLowerBound = V(value.location.x / (geometry.size.width - self.thumbRadius * 2))
                            let validatedLowerBound = max(self.boundingRange.lowerBound, newLowerBound)
                            let validatedUpperBound = max(validatedLowerBound, self.range.value.upperBound)
                            self.range.value = (validatedLowerBound...validatedUpperBound).clamped(to: self.boundingRange)
                        }
                    )

                Circle()
                    .frame(width: self.thumbRadius, height: self.thumbRadius)
                    .shadow(radius: 3)
                    .offset(x: 28 + (geometry.size.width - self.thumbRadius * 2) * CGFloat(self.range.value.upperBound))
                    .gesture(
                        DragGesture().onChanged { value in
                            let newUpperBound = V((value.location.x - self.thumbRadius) / (geometry.size.width - self.thumbRadius * 2))
                            let validatedUpperBound = min(self.boundingRange.upperBound, newUpperBound)
                            let validatedLowerBound = min(validatedUpperBound, self.range.value.lowerBound)
                            self.range.value = (validatedLowerBound...validatedUpperBound).clamped(to: self.boundingRange)
                        }
                    )
            }
            .frame(height: 30)
        }
        .frame(height: 30)
    }
}

private struct RangeSliderTrack: View {
    var body: some View {
        Rectangle()
            .frame(height: 3)
            .cornerRadius(1.5)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.secondary)
    }
}

#if DEBUG

struct RangeSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            RangeSliderTrack()
        }
    }
}
#endif
