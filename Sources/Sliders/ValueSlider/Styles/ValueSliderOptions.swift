import SwiftUI

@MainActor
public struct ValueSliderOptions: OptionSet {
    public let rawValue: Int

    public static let interactiveTrack = ValueSliderOptions(rawValue: 1 << 0)
    public static let defaultOptions: ValueSliderOptions = []
    
    nonisolated public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
