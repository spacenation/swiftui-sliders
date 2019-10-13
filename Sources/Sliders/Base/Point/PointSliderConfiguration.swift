import SwiftUI

public struct PointSliderConfiguration {
    public static let defaultConfiguration = PointSliderConfiguration()

    public let thumbSize: CGSize
    public let thumbInteractiveSize: CGSize
    
    public init(thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize) {
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
    }
}

extension PointSliderConfiguration {
    static let defaultThumbSize: CGSize = CGSize(width: 27, height: 27)
    static let defaultThumbInteractiveSize : CGSize = CGSize(width: 44, height: 44)
}
