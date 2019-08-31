import SwiftUI

extension SliderBase {
    var height: CGFloat {
        preferences.height ?? style.height
    }
    
    var thickness: CGFloat {
        preferences.thickness ?? style.thickness
    }
    
    var thumbSize: CGSize {
        preferences.thumbSize ?? style.thumbSize
    }
    
    var thumbColor: Color {
        preferences.thumbColor ?? style.thumbColor
    }
    
    var thumbBorderColor: Color {
        preferences.thumbBorderColor ?? style.thumbBorderColor
    }
    
    var thumbBorderWidth: CGFloat {
        preferences.thumbBorderWidth ?? style.thumbBorderWidth
    }
    
    var thumbShadowColor: Color {
        preferences.thumbShadowColor ?? style.thumbShadowColor
    }
    
    var thumbShadowRadius: CGFloat {
        preferences.thumbShadowRadius ?? style.thumbShadowRadius
    }
    
    var thumbShadowX: CGFloat {
        preferences.thumbShadowX ?? style.thumbShadowX
    }
    
    var thumbShadowY: CGFloat {
        preferences.thumbShadowY ?? style.thumbShadowY
    }
    
    var valueColor: Color {
        preferences.valueColor ?? style.valueColor
    }
    
    var trackColor: Color {
        preferences.trackColor ?? style.trackColor
    }
    
    var trackBorderColor: Color {
        preferences.trackBorderColor ?? style.trackBorderColor
    }
    
    var trackBorderWidth: CGFloat {
        preferences.trackBorderWidth ?? style.trackBorderWidth
    }
    
    var clippedValue: Bool {
        preferences.clippedValue ?? style.clippedValue
    }
}
