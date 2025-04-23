import SwiftUI

public extension EnvironmentValues {
    var valueTrackConfiguration: ValueTrackConfiguration {
        get {
            return self[ValueTrackConfigurationKey.self]
        }
        set {
            self[ValueTrackConfigurationKey.self] = newValue
        }
    }
}

@MainActor
struct ValueTrackConfigurationKey: @preconcurrency EnvironmentKey {
    static let defaultValue: ValueTrackConfiguration = .defaultConfiguration
}
