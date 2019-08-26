import SwiftUI

public struct DefaultSliderStyle: SliderStyle {
    public var knobSize: CGSize = CGSize(width: 27, height: 27)
    public var knobCornerRadius: CGFloat = 13.5
    public var thickness: CGFloat = 3
    public var height: CGFloat = 30
    public var clippedValue: Bool = true
}
