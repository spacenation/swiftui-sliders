import SwiftUI

public typealias VRangeTrack = VerticalRangeTrack

public struct VerticalRangeTrack<V, ValueView: View, MaskView: View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: ClosedRange<CGFloat>
    let bounds: ClosedRange<CGFloat>
    let view: AnyView
    let mask: AnyView
    let lowerLeadingOffset: CGFloat
    let lowerTrailingOffset: CGFloat
    let upperLeadingOffset: CGFloat
    let upperTrailingOffset: CGFloat
    
    public var body: some View {
        GeometryReader { geometry in
            self.view
                .mask(
                    ZStack {
                        self.mask
                             .frame(
                                 height: rangeDistance(
                                    overallLength: geometry.size.height,
                                    range: self.range,
                                    bounds: self.bounds,
                                    lowerStartOffset: self.lowerLeadingOffset,
                                    lowerEndOffset: self.lowerTrailingOffset,
                                    upperStartOffset: self.upperLeadingOffset,
                                    upperEndOffset: self.upperTrailingOffset
                                 )
                             )
                             .offset(
                                 y: -distanceFrom(
                                    value: self.range.lowerBound,
                                    availableDistance: geometry.size.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.lowerLeadingOffset,
                                    trailingOffset: self.lowerTrailingOffset
                                 )
                             )
                    }
                    .frame(height: geometry.size.height, alignment: .bottom)
                )
        }
        .frame(minWidth: 1)
    }
}

extension VerticalRangeTrack {
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

extension VerticalRangeTrack where ValueView == DefaultVerticalValueView {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, mask: MaskView, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, view: DefaultVerticalValueView(), mask: mask, lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}

extension VerticalRangeTrack where MaskView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, value: ValueView, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, view: value, mask: Capsule(), lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}

extension VerticalRangeTrack where ValueView == DefaultVerticalValueView, MaskView == Capsule {
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, lowerLeadingOffset: CGFloat = 0, lowerTrailingOffset: CGFloat = 0, upperLeadingOffset: CGFloat = 0, upperTrailingOffset: CGFloat = 0) {
        self.init(range: range, in: bounds, view: DefaultVerticalValueView(), mask: Capsule(), lowerLeadingOffset: lowerLeadingOffset, lowerTrailingOffset: lowerTrailingOffset, upperLeadingOffset: upperLeadingOffset, upperTrailingOffset: upperTrailingOffset)
    }
}
