import SwiftUI

extension EnvironmentValues {
    var pointTrackConfiguration: PointTrackConfiguration {
        get {
            return self[PointTrackConfigurationKey.self]
        }
        set {
            self[PointTrackConfigurationKey.self] = newValue
        }
    }
}

@MainActor
struct PointTrackConfigurationKey: @preconcurrency EnvironmentKey {
    static let defaultValue: PointTrackConfiguration = .defaultConfiguration
}
