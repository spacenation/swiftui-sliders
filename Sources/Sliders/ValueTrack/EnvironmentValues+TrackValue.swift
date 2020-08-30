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
