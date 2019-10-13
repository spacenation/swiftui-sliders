import SwiftUI

public struct RangeSliderConfiguration {
    public static let defaultConfiguration = RangeSliderConfiguration()

    let lowerThumbSize: CGSize
    let upperThumbSize: CGSize
    
    let lowerThumbInteractiveSize: CGSize
    let upperThumbInteractiveSize: CGSize
    
    public init(lowerThumbSize: CGSize = .defaultThumbSize, upperThumbSize: CGSize = .defaultThumbSize, lowerThumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, upperThumbInteractiveSize: CGSize = .defaultThumbInteractiveSize) {
        self.lowerThumbSize = lowerThumbSize
        self.upperThumbSize = upperThumbSize
        self.lowerThumbInteractiveSize = lowerThumbInteractiveSize
        self.upperThumbInteractiveSize = upperThumbInteractiveSize
    }
}

public extension RangeSliderConfiguration {
    init(thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize) {
        self.lowerThumbSize = thumbSize
        self.upperThumbSize = thumbSize
        self.lowerThumbInteractiveSize = thumbInteractiveSize
        self.upperThumbInteractiveSize = thumbInteractiveSize
    }
}

extension RangeSliderConfiguration {
    static let defaultThumbSize: CGSize = CGSize(width: 27, height: 27)
    static let defaultThumbInteractiveSize : CGSize = CGSize(width: 44, height: 44)
}

extension RangeSliderConfiguration {
    var horizontalTrackConfiguration: RangeTrackConfiguration {
        RangeTrackConfiguration(
            lowerLeadingOffset: lowerThumbSize.width / 2,
            lowerTrailingOffset: lowerThumbSize.width / 2 + upperThumbSize.width,
            upperLeadingOffset: lowerThumbSize.width + upperThumbSize.width / 2,
            upperTrailingOffset: upperThumbSize.width / 2
        )
    }
    
    var verticalTrackConfiguration: RangeTrackConfiguration {
        RangeTrackConfiguration(
            lowerLeadingOffset: lowerThumbSize.height / 2,
            lowerTrailingOffset: lowerThumbSize.height / 2 + upperThumbSize.height,
            upperLeadingOffset: lowerThumbSize.height + upperThumbSize.height / 2,
            upperTrailingOffset: upperThumbSize.height / 2
        )
    }
}
