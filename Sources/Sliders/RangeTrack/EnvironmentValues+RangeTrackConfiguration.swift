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

@MainActor
struct RangeTrackConfigurationKey: @preconcurrency EnvironmentKey {
    static let defaultValue: RangeTrackConfiguration = .defaultConfiguration
}
