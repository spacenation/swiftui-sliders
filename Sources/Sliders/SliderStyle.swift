import SwiftUI

public protocol SliderStyle {
    var height: CGFloat { get set }
    var thickness: CGFloat { get set }
    var knobSize: CGSize { get set }
    var knobCornerRadius: CGFloat { get set }
    
    var knobView: AnyView { get }
    var valueView: AnyView { get }
    var trackView: AnyView { get }
    
    var clippedValue: Bool { get set }
}

extension SliderStyle {
    public var knobView: AnyView {
        AnyView(Rectangle()
            .frame(width: self.knobSize.width, height: self.knobSize.height)
            .foregroundColor(.white)
            .cornerRadius(self.knobCornerRadius)
            .shadow(radius: 3)
        )
    }
    
    public var valueView: AnyView {
        AnyView(Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: self.thickness)
            .cornerRadius(self.thickness / 2)
            .foregroundColor(.accentColor)
        )
    }
    
    public var trackView: AnyView {
        AnyView(Rectangle()
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: self.thickness)
            .cornerRadius(self.thickness / 2)
            .foregroundColor(.secondary)
            .opacity(0.25)
        )
    }
}
