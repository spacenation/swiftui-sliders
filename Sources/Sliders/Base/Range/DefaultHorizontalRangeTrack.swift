import SwiftUI

public struct DefaultHorizontalRangeTrack<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: ClosedRange<V>
    let bounds: ClosedRange<V>
    var lowerLeadingOffset: CGFloat
    var lowerTrailingOffset: CGFloat
    var upperLeadingOffset: CGFloat
    var upperTrailingOffset: CGFloat
    
    public var body: some View {
        HRangeTrack(
            range: range,
            in: bounds,
            lowerLeadingOffset: lowerLeadingOffset,
            lowerTrailingOffset: lowerTrailingOffset,
            upperLeadingOffset: upperLeadingOffset,
            upperTrailingOffset: upperTrailingOffset
        )
        .frame(height: 3)
        .background(Color.secondary.opacity(0.25))
        .cornerRadius(1.5)
    }
    
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.range = range
        self.bounds = bounds
        self.lowerLeadingOffset = lowerLeadingOffset
        self.lowerTrailingOffset = lowerTrailingOffset
        self.upperLeadingOffset = upperLeadingOffset
        self.upperTrailingOffset = upperTrailingOffset
    }
}

#if DEBUG
struct DefaultHorizontalRangeTrack_Previews: PreviewProvider {
    static var previews: some View {
        DefaultHorizontalRangeTrack(range: 0.5...0.9)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif
