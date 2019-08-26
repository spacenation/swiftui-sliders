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
    @available(tvOS, unavailable)
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0...1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.value = value
        self.bounds = bounds
        self.step = 0.001
        self.onEditingChanged = onEditingChanged
    }

    /// Creates an instance that selects a value from within a range.
    ///
    /// - Parameters:
    ///     - value: The selected range within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - step: The distance between each valid value.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `RangeSlider` is considered to be actively editing while
    /// the user is touching the knob and sliding it around the track.
    @available(tvOS, unavailable)
    public init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.value = value
        self.bounds = bounds
        self.step = V(step)
        self.onEditingChanged = onEditingChanged
    }
}
