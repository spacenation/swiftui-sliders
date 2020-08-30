import SwiftUI

extension EnvironmentValues {
    var valueTrackConfiguration: ValueTrackConfiguration {
        get {
            return self[ValueTrackConfigurationKey.self]
        }
        set {
            self[ValueTrackConfigurationKey.self] = newValue
        }
    }
}

struct ValueTrackConfigurationKey: EnvironmentKey {
    static let defaultValue: ValueTrackConfiguration = .defaultConfiguration
}
