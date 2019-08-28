import SwiftUI

extension RangeSlider {
    /// Creates an instance that selects a range from within a range.
    ///
    /// - Parameters:
    ///     - range: The selected range within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - step: The distance between each valid value. Defaults to `0.001`.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `RangeSlider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        assert(range.wrappedValue.lowerBound >= bounds.lowerBound, "Range value \(range.wrappedValue) is out of bounds \(bounds)")
        assert(range.wrappedValue.upperBound <= bounds.upperBound, "Range value \(range.wrappedValue) is out of bounds \(bounds)")
        self.range = range
        self.bounds = bounds
        self.step = V(step)
        self.onEditingChanged = onEditingChanged
    }
}
