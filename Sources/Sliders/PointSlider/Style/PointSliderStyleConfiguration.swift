import SwiftUI

public struct PointSliderStyleConfiguration {
    public let x: Binding<CGFloat>
    public let xBounds: ClosedRange<CGFloat>
    public let xStep: CGFloat

    public let y: Binding<CGFloat>
    public let yBounds: ClosedRange<CGFloat>
    public let yStep: CGFloat
    
    public let onEditingChanged: (Bool) -> Void
    public var dragOffset: Binding<CGPoint?>
    
    func with(dragOffset: Binding<CGPoint?>) -> Self {
        var mutSelf = self
        mutSelf.dragOffset = dragOffset
        return mutSelf
    }
}
