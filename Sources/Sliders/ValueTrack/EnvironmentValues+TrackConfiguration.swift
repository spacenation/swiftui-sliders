import SwiftUI

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
