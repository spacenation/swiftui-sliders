import Foundation

public struct EditingRange: OptionSet {
    public let rawValue: UInt8

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public static let upper = EditingRange(rawValue: 0b01)
    public static let lower = EditingRange(rawValue: 0b10)
}
