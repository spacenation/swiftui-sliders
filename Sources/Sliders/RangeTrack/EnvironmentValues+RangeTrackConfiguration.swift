import SwiftUI

extension EnvironmentValues {
    var rangeTrackConfiguration: RangeTrackConfiguration {
        get {
            return self[RangeTrackConfigurationKey.self]
        }
        set {
            self[RangeTrackConfigurationKey.self] = newValue
        }
    }
}

struct RangeTrackConfigurationKey: EnvironmentKey {
    static let defaultValue: RangeTrackConfiguration = .defaultConfiguration
}
