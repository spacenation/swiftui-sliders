import SwiftUI

public extension EnvironmentValues {
    var trackRange: ClosedRange<CGFloat> {
        get {
            return self[TrackRangeKey.self]
        }
        set {
            self[TrackRangeKey.self] = newValue
        }
    }
}

public struct TrackRangeKey: EnvironmentKey {
    public static let defaultValue: ClosedRange<CGFloat> = 0.0...1.0
}
