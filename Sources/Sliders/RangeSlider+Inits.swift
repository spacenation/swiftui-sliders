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
    /// the user is touching the thumb and sliding it around the track.
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 0.001, trackView: TrackView, valueView: ValueView, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.range = range
        self.bounds = bounds
        self.step = step
        
        self.trackView = trackView
        self.valueView = valueView
        self.thumbView = thumbView
        
        self.onEditingChanged = onEditingChanged
    }
}

extension RangeSlider where TrackView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, valueView: ValueView, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: valueView, thumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where ValueView == Rectangle {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, valueView: Rectangle(), thumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where ThumbView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, valueView: ValueView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, valueView: valueView, thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where ThumbView == Capsule, ValueView == Rectangle {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, valueView: Rectangle(), thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where TrackView == Capsule, ValueView == Rectangle {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: Rectangle(), thumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where TrackView == Capsule, ThumbView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, valueView: ValueView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: valueView, thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension RangeSlider where TrackView == Capsule, ValueView == Rectangle, ThumbView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: Rectangle(), thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}
