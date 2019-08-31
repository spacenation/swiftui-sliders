import Foundation
import SwiftUI

public extension RangeSlider {
    @inlinable func height(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferredHeight = length
        return copy
    }
    
    @inlinable func thickness(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferredThickness = length
        return copy
    }
    
    @inlinable func thumbSize(_ size: CGSize?) -> Self {
        var copy = self
        copy.preferredThumbSize = size
        return copy
    }
    
    @inlinable func thumbColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferredThumbColor = color
        return copy
    }
    
    @inlinable func thumbBorderColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferredThumbBorderColor = color
        return copy
    }
    
    @inlinable func thumbBorderWidth(_ width: CGFloat?) -> Self {
        var copy = self
        copy.preferredThumbBorderWidth = width
        return copy
    }
    
    @inlinable func thumbShadowColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferredThumbShadowColor = color
        return copy
    }

    @inlinable func thumbShadowRadius(_ radius: CGFloat?) -> Self {
        var copy = self
        copy.preferredThumbShadowRadius = radius
        return copy
    }

    @inlinable func thumbShadowX(_ offset: CGFloat?) -> Self {
        var copy = self
        copy.preferredThumbShadowX = offset
        return copy
    }

    @inlinable func thumbShadowY(_ offset: CGFloat?) -> Self {
        var copy = self
        copy.preferredThumbShadowY = offset
        return copy
    }
    
    @inlinable func valueColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferredValueColor = color
        return copy
    }
    
    @inlinable func trackColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferredTrackColor = color
        return copy
    }

    @inlinable func trackBorderColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferredTrackBorderColor = color
        return copy
    }

    @inlinable func trackBorderWidth(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferredTrackBorderWidth = length
        return copy
    }
    
    @inlinable func clippedValue(_ isClipped: Bool?) -> Self {
        var copy = self
        copy.preferClippedValue = isClipped
        return copy
    }
}
