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

struct PointTrackConfigurationKey: EnvironmentKey {
    static let defaultValue: PointTrackConfiguration = .defaultConfiguration
}
