import SwiftUI

public extension EnvironmentValues {
    var trackValue: CGFloat {
        get {
            return self[TrackValueKey.self]
        }
        set {
            self[TrackValueKey.self] = newValue
        }
    }
}

public struct TrackValueKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0.0
}

extension EnvironmentValues {
    var trackConfiguration: ValueTrackConfiguration {
        get {
            return self[TrackConfigurationKey.self]
        }
        set {
            self[TrackConfigurationKey.self] = newValue
        }
    }
}

struct TrackConfigurationKey: EnvironmentKey {
    static let defaultValue: ValueTrackConfiguration = .defaultConfiguration
}

public typealias Track = ValueTrack

public struct ValueTrack<ValueView: View, MaskView: View>: View {
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
                                width: distanceFrom(
                                    value: self.value,
                                    availableDistance: geometry.size.width,
                                    bounds: self.configuration.bounds,
                                    leadingOffset: self.configuration.leadingOffset,
                                    trailingOffset: self.configuration.trailingOffset
                                )
                            )
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                )
        }
    }
}

extension ValueTrack {
    public init(view: ValueView, mask: MaskView) {
        self.view = AnyView(view)
        self.mask = AnyView(mask)
    }
}

extension ValueTrack where ValueView == DefaultHorizontalValueView {
    public init(mask: MaskView) {
        self.init(view: DefaultHorizontalValueView(), mask: mask)
    }
}

extension ValueTrack where MaskView == Capsule {
    public init(view: ValueView) {
        self.init(view: view, mask: Capsule())
    }
}

extension ValueTrack where ValueView == DefaultHorizontalValueView, MaskView == Capsule {
    public init() {
        self.init(view: DefaultHorizontalValueView(), mask: Capsule())
    }
}
