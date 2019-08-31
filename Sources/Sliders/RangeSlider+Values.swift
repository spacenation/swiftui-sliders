import SwiftUI

extension RangeSlider {
    var height: CGFloat {
        preferredHeight ?? sliderStyle.height
    }
    
    var thickness: CGFloat {
        preferredThickness ?? sliderStyle.thickness
    }
    
    var thumbSize: CGSize {
        preferredThumbSize ?? sliderStyle.thumbSize
    }
    
    var thumbColor: Color {
        preferredThumbColor ?? sliderStyle.thumbColor
    }
    
    var thumbBorderColor: Color {
        preferredThumbBorderColor ?? sliderStyle.thumbBorderColor
    }
    
    var thumbBorderWidth: CGFloat {
        preferredThumbBorderWidth ?? sliderStyle.thumbBorderWidth
    }
    
    var thumbShadowColor: Color {
        preferredThumbShadowColor ?? sliderStyle.thumbShadowColor
    }
    
    var thumbShadowRadius: CGFloat {
        preferredThumbShadowRadius ?? sliderStyle.thumbShadowRadius
    }
    
    var thumbShadowX: CGFloat {
        preferredThumbShadowX ?? sliderStyle.thumbShadowX
    }
    
    var thumbShadowY: CGFloat {
        preferredThumbShadowY ?? sliderStyle.thumbShadowY
    }
    
    var valueColor: Color {
        preferredValueColor ?? sliderStyle.valueColor
    }
    
    var trackColor: Color {
        preferredTrackColor ?? sliderStyle.trackColor
    }
    
    var trackBorderColor: Color {
        preferredTrackBorderColor ?? sliderStyle.trackBorderColor
    }
    
    var trackBorderWidth: CGFloat {
        preferredTrackBorderWidth ?? sliderStyle.trackBorderWidth
    }
    
    var clippedValue: Bool {
        preferClippedValue ?? sliderStyle.clippedValue
    }
}
