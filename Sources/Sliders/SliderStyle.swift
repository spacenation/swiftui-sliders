import SwiftUI

public protocol SliderStyle {
    var height: CGFloat { get set }
    var thickness: CGFloat { get set }
    var knobSize: CGSize { get set }
    var knobCornerRadius: CGFloat { get set }
    var trackCornerRadius: CGFloat? { get set }
    
    var knobView: AnyView { get }
    var valueView: AnyView { get }
    var trackView: AnyView { get }
    
    var clippedValue: Bool { get set }
}

extension SliderStyle {
    public var knobView: AnyView {
        AnyView(Rectangle()
            .foregroundColor(.white)
        )
        
    }
    
    public var valueView: AnyView {
        AnyView(Rectangle()
            .foregroundColor(.accentColor)
        )
    }
    
    public var trackView: AnyView {
        AnyView(Rectangle()
            .foregroundColor(.secondary)
            .opacity(0.25)
        )
    }
}
