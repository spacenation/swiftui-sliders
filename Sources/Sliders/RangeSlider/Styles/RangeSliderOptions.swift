import SwiftUI

@MainActor
public struct RangeSliderOptions: OptionSet {
    public let rawValue: Int

    public static let forceAdjacentValue = RangeSliderOptions(rawValue: 1 << 0)
    public static let defaultOptions: RangeSliderOptions = .forceAdjacentValue
    
    nonisolated public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
