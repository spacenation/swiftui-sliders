import SwiftUI

public struct DefaultHorizontalValueTrack<V>: View where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint {
    let value: V
    let bounds: ClosedRange<V>
    let leadingOffset: CGFloat
    let trailingOffset: CGFloat

    public var body: some View {
        HTrack(value: value, in: bounds, leadingOffset: leadingOffset, trailingOffset: trailingOffset)
            .frame(height: 3)
            .background(Color.secondary.opacity(0.25))
            .cornerRadius(1.5)
    }
    
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.value = value
        self.bounds = bounds
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
    }
}

#if DEBUG
struct DefaultHorizontalValueTrack_Previews: PreviewProvider {
    static var previews: some View {
        DefaultHorizontalValueTrack(value: 0.5)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif
