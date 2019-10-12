import SwiftUI

public typealias VTrack = VerticalValueTrack

public struct VerticalValueTrack<V, ValueView: View, MaskView: View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: CGFloat
    let bounds: ClosedRange<CGFloat>
    let view: AnyView
    let mask: AnyView
    let leadingOffset: CGFloat
    let trailingOffset: CGFloat
    
    public var body: some View {
        GeometryReader { geometry in
            self.view
                .mask(
                    ZStack {
                        self.mask
                            .frame(
                                height: distanceFrom(
                                    value: self.value,
                                    availableDistance: geometry.size.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.leadingOffset,
                                    trailingOffset: self.trailingOffset
                                )
                            )
                    }
                    .frame(height: geometry.size.height, alignment: .bottom)
                )
        }
    }
}

extension VerticalValueTrack {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, view: ValueView, mask: MaskView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.value = CGFloat(value)
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.view = AnyView(view)
        self.mask = AnyView(mask)
        self.leadingOffset = leadingOffset
        self.trailingOffset = trailingOffset
    }
}

extension VerticalValueTrack where ValueView == DefaultVerticalValueView {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, mask: MaskView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, view: DefaultVerticalValueView(), mask: mask, leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}

extension VerticalValueTrack where MaskView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, view: ValueView, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, view: view, mask: Capsule(), leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}

extension VerticalValueTrack where ValueView == DefaultVerticalValueView, MaskView == Capsule {
    public init(value: V, in bounds: ClosedRange<V> = 0.0...1.0, leadingOffset: CGFloat = 0, trailingOffset: CGFloat = 0) {
        self.init(value: value, in: bounds, view: DefaultVerticalValueView(), mask: Capsule(), leadingOffset: leadingOffset, trailingOffset: trailingOffset)
    }
}
