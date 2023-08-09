import SwiftUI

public struct ValueSliderOptions: OptionSet {
    public let rawValue: Int

    public static let interactiveTrack = ValueSliderOptions(rawValue: 1 << 0)
    public static let defaultOptions: ValueSliderOptions = []
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
