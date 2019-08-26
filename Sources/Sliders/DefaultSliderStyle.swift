import SwiftUI

public struct DefaultSliderStyle: SliderStyle {
    public var thumbRadius: CGFloat = 27
    public var thickness: CGFloat = 3
    public var height: CGFloat = 30
    
    public var clippedValue: Bool = true
    
    public var valueView: AnyView {
        AnyView(Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.accentColor)
        )
    }
}
