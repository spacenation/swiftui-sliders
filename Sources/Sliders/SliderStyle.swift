import SwiftUI

public protocol SliderStyle {
    var height: CGFloat { get set }
    var thickness: CGFloat { get set }
    
    var thumbSize: CGSize { get set }
    var thumbColor: Color { get set }
    var thumbBorderColor: Color { get set }
    var thumbBorderWidth: CGFloat { get set }
    var thumbShadowColor: Color { get set }
    var thumbShadowRadius: CGFloat { get set }
    var thumbShadowX: CGFloat { get set }
    var thumbShadowY: CGFloat { get set }
    
    var valueColor: Color { get set }
    
    var trackColor: Color { get set }
    var trackBorderColor: Color { get set }
    var trackBorderWidth: CGFloat { get set }
        
    var clippedValue: Bool { get set }
}
