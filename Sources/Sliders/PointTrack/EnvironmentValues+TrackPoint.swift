import SwiftUI

public extension EnvironmentValues {
    var trackPointX: CGFloat {
        get {
            return self[TrackPointXKey.self]
        }
        set {
            self[TrackPointXKey.self] = newValue
        }
    }
    
    var trackPointY: CGFloat {
        get {
            return self[TrackPointYKey.self]
        }
        set {
            self[TrackPointYKey.self] = newValue
        }
    }
}

public struct TrackPointXKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0.0
}

public struct TrackPointYKey: EnvironmentKey {
    public static let defaultValue: CGFloat = 0.0
}
