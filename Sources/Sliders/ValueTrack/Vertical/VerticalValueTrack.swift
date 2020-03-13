import SwiftUI

public typealias VerticalTrack = VerticalValueTrack

public struct VerticalValueTrack<ValueView: View, MaskView: View>: View {
    @Environment(\.trackValue) var value
    @Environment(\.trackConfiguration) var configuration
    let view: AnyView
    let mask: AnyView
    
    public var body: some View {
        GeometryReader { geometry in
            self.view.accentColor(.accentColor)
                .mask(
                    ZStack {
                        self.mask
                            .frame(
                                height: distanceFrom(
                                    value: self.value,
                                    availableDistance: geometry.size.height,
                                    bounds: self.configuration.bounds,
                                    leadingOffset: self.configuration.leadingOffset,
                                    trailingOffset: self.configuration.trailingOffset
                                )
                            )
                    }
                    .frame(height: geometry.size.height, alignment: .bottom)
                )
        }
    }
}

extension VerticalValueTrack {
    public init(view: ValueView, mask: MaskView) {
        self.view = AnyView(view)
        self.mask = AnyView(mask)
    }
}

extension VerticalValueTrack where ValueView == DefaultVerticalValueView {
    public init(mask: MaskView) {
        self.init(view: DefaultVerticalValueView(), mask: mask)
    }
}

extension VerticalValueTrack where MaskView == Capsule {
    public init(view: ValueView) {
        self.init(view: view, mask: Capsule())
    }
}

extension VerticalValueTrack where ValueView == DefaultVerticalValueView, MaskView == Capsule {
    public init() {
        self.init(view: DefaultVerticalValueView(), mask: Capsule())
    }
}
