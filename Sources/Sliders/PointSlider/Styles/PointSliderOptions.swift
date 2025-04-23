import SwiftUI

public struct PointSliderOptions: OptionSet {
    public let rawValue: Int

    @MainActor public static let interactiveTrack = PointSliderOptions(rawValue: 1 << 0)
    @MainActor public static let defaultOptions: PointSliderOptions = []
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
