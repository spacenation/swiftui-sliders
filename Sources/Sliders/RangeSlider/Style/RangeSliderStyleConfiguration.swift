import SwiftUI

public struct RangeSliderStyleConfiguration {
    public let range: Binding<ClosedRange<CGFloat>>
    public let bounds: ClosedRange<CGFloat>
    public let step: CGFloat
    public let distance: ClosedRange<CGFloat>
    public let onEditingChanged: (Bool) -> Void
    public var dragOffset: Binding<CGFloat?>
    
    func with(dragOffset: Binding<CGFloat?>) -> Self {
        var mutSelf = self
        mutSelf.dragOffset = dragOffset
        return mutSelf
    }
}
