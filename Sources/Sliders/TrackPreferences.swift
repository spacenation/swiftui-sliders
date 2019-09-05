import SwiftUI

@usableFromInline
struct TrackPreferences {
    @usableFromInline
    var valueColor: Color? = nil
    
    @usableFromInline
    var backgroundColor: Color? = nil
    
    @usableFromInline
    var borderColor: Color? = nil
    
    @usableFromInline
    var borderWidth: CGFloat? = nil
    
    @usableFromInline
    var startOffset: CGFloat? = nil
    
    @usableFromInline
    var endOffset: CGFloat? = nil
    
    @usableFromInline
    var lowerStartOffset: CGFloat? = nil
    
    @usableFromInline
    var lowerEndOffset: CGFloat? = nil
    
    @usableFromInline
    var upperStartOffset: CGFloat? = nil
    
    @usableFromInline
    var upperEndOffset: CGFloat? = nil
}
