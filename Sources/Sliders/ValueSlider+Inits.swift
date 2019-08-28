import SwiftUI

extension ValueSlider {
    /// Creates an instance that selects a value from within a range.
    ///
    /// - Parameters:
    ///     - value: The selected value within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `RangeSlider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        assert(value.wrappedValue >= bounds.lowerBound, "Value \(value.wrappedValue) is out of bounds \(bounds)")
        assert(value.wrappedValue <= bounds.upperBound, "Value \(value.wrappedValue) is out of bounds \(bounds)")
        self.value = value
        self.bounds = bounds
        self.step = V(step)
        self.onEditingChanged = onEditingChanged
    }
}
