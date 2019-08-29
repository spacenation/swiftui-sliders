import SwiftUI

public protocol SliderStyle {
    var height: CGFloat { get set }
    var thickness: CGFloat { get set }
    
    var knobSize: CGSize { get set }
    var knobColor: Color { get set }
    var knobCornerRadius: CGFloat { get set }
    var knobBorderColor: Color { get set }
    var knobBorderWidth: CGFloat { get set }
    var knobShadowColor: Color { get set }
    var knobShadowRadius: CGFloat { get set }
    var knobShadowX: CGFloat { get set }
    var knobShadowY: CGFloat { get set }
    
    var valueColor: Color { get set }
    
    var trackColor: Color { get set }
    var trackCornerRadius: CGFloat? { get set }
    var trackBorderColor: Color { get set }
    var trackBorderWidth: CGFloat { get set }
        
    var clippedValue: Bool { get set }
    
    var knobView: AnyView { get }
    var valueView: AnyView { get }
    var trackView: AnyView { get }
}
