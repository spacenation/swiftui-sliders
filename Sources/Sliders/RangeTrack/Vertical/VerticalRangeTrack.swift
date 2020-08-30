import SwiftUI

public struct VerticalRangeTrack<ValueView: View, MaskView: View>: View {
    @Environment(\.trackRange) var range
    @Environment(\.rangeTrackConfiguration) var configuration
    let view: AnyView
    let mask: AnyView
    
    public var body: some View {
        GeometryReader { geometry in
            self.view
                .accentColor(.accentColor)
                .mask(
                    ZStack {
                        self.mask
                             .frame(
                                 height: rangeDistance(
                                    overallLength: geometry.size.height,
                                    range: self.range,
                                    bounds: self.configuration.bounds,
                                    lowerStartOffset: self.configuration.lowerLeadingOffset,
                                    lowerEndOffset: self.configuration.lowerTrailingOffset,
                                    upperStartOffset: self.configuration.upperLeadingOffset,
                                    upperEndOffset: self.configuration.upperTrailingOffset
                                 )
                             )
                             .offset(
                                 y: -distanceFrom(
                                    value: self.range.lowerBound,
                                    availableDistance: geometry.size.height,
                                    bounds: self.configuration.bounds,
                                    leadingOffset: self.configuration.lowerLeadingOffset,
                                    trailingOffset: self.configuration.lowerTrailingOffset
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
    public init(view: ValueView, mask: MaskView) {
        self.view = AnyView(view)
        self.mask = AnyView(mask)
    }
}

extension VerticalRangeTrack where ValueView == DefaultVerticalValueView {
    public init(mask: MaskView) {
        self.init(view: DefaultVerticalValueView(), mask: mask)
    }
}

extension VerticalRangeTrack where MaskView == Capsule {
    public init(view: ValueView) {
        self.init(view: view, mask: Capsule())
    }
}

extension VerticalRangeTrack where ValueView == DefaultVerticalValueView, MaskView == Capsule {
    public init() {
        self.init(view: DefaultVerticalValueView(), mask: Capsule())
    }
}
