import SwiftUI

public typealias HRangeTrack = HorizontalRangeTrack

public struct HorizontalRangeTrack<V, ValueView: View, MaskView: View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint  {
    let range: ClosedRange<CGFloat>
    let bounds: ClosedRange<CGFloat>
    let view: AnyView
    let mask: AnyView
    var lowerLeadingOffset: CGFloat
    var lowerTrailingOffset: CGFloat
    var upperLeadingOffset: CGFloat
    var upperTrailingOffset: CGFloat
    
    public var body: some View {
        GeometryReader { geometry in
            self.view
                .mask(
                    ZStack {
                        self.mask
                             .frame(
                                 width: rangeDistance(
                                    overallLength: geometry.size.width,
                                    range: self.range,
                                    bounds: self.bounds,
                                    lowerStartOffset: self.lowerLeadingOffset,
                                    lowerEndOffset: self.lowerTrailingOffset,
                                    upperStartOffset: self.upperLeadingOffset,
                                    upperEndOffset: self.upperTrailingOffset
                                 )
                             )
                             .offset(
                                 x: distanceFrom(
                                    value: self.range.lowerBound,
                                    availableDistance: geometry.size.width,
                                    bounds: self.bounds,
                                    leadingOffset: self.lowerLeadingOffset,
                                    trailingOffset: self.lowerTrailingOffset
                                 )
                             )
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                )
        }
    }
}

extension HorizontalRangeTrack {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, view: ValueView, mask: MaskView, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.range = CGFloat(range.lowerBound)...CGFloat(range.upperBound)
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.view = AnyView(view)
        self.mask = AnyView(mask)
        self.lowerLeadingOffset = lowerLeadingOffset
        self.lowerTrailingOffset = lowerTrailingOffset
        self.upperLeadingOffset = upperLeadingOffset
        self.upperTrailingOffset = upperTrailingOffset
    }
}

extension HorizontalRangeTrack where ValueView == DefaultHorizontalValueView {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, mask: MaskView, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, view: DefaultHorizontalValueView(), mask: mask, lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}

extension HorizontalRangeTrack where MaskView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, view: ValueView, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, view: view, mask: Capsule(), lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}

extension HorizontalRangeTrack where ValueView == DefaultHorizontalValueView, MaskView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, view: DefaultHorizontalValueView(), mask: Capsule(), lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}
