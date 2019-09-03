import SwiftUI

public struct VerticalRangeSlider<V, TrackView: InsettableShape, ValueView: View, ThumbView : InsettableShape>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle)
    var style
    
    @usableFromInline
    var preferences = SliderPreferences()
    
    let range: Binding<ClosedRange<V>>
    let bounds: ClosedRange<V>
    let step: V.Stride
    
    let trackView: TrackView
    let valueView: ValueView
    let thumbView: ThumbView
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffsetY: CGFloat? = nil

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .init(horizontal: .center, vertical: .bottom)) {
                self.generatedValueTrackView(geometry: geometry, valueView: self.valueView, trackView: self.trackView)
                
                self.generatedThumbView(view: self.thumbView)
                    .offset(y: -(self.yForLowerBound(height: geometry.size.height)))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetY == nil {
                                    self.dragOffsetY = value.startLocation.y + self.yForLowerBound(height: geometry.size.height)
                                }
                                let relativeValue: CGFloat = (value.location.y - (self.dragOffsetY ?? 0)) / (geometry.size.height - self.thumbSize.height * 2)
                                let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                                let computedLowerBound = valueFrom(relativeValue: -relativeValue, bounds: bounds, step: CGFloat(self.step))
                                let computedUpperBound = max(computedLowerBound, CGFloat(self.range.wrappedValue.upperBound))
                                self.range.wrappedValue = (V(computedLowerBound)...V(computedUpperBound)).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetY = nil
                                self.onEditingChanged(false)
                            }
                    )

                self.generatedThumbView(view: self.thumbView)
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                    .rotationEffect(Angle(degrees: 180))
                    .offset(y: -(self.thumbSize.height + self.yForUpperBound(height: geometry.size.height)))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if self.dragOffsetY == nil {
                                    self.dragOffsetY = self.thumbSize.height - (value.startLocation.y + self.yForUpperBound(height: geometry.size.height))
                                }
                                let relativeValue: CGFloat = ((value.location.y - self.thumbSize.height) + (self.dragOffsetY ?? 0)) / (geometry.size.height - self.thumbSize.height * 2)
                                let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                                let computedUpperBound = valueFrom(relativeValue: -relativeValue, bounds: bounds, step: CGFloat(self.step))
                                let computedLowerBound = min(computedUpperBound, CGFloat(self.range.wrappedValue.lowerBound))
                                self.range.wrappedValue = (V(computedLowerBound)...V(computedUpperBound)).clamped(to: self.bounds)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetY = nil
                                self.onEditingChanged(false)
                            }
                    )
            }
            .frame(width: self.width)
        }
        .frame(width: self.width)
        
        /// Enabling this draws incorrect gradient in value, fix it before enabling metal randering
        //.drawingGroup()
    }
    
    func valueOffset(overallHeight: CGFloat) -> CGFloat {
        let halfHeight = ((overallHeight - self.thumbSize.height * 2) / 2)
        return (yForLowerBound(height: overallHeight) - halfHeight) + valueHeight(overallHeight: overallHeight) / 2
    }
    
    func valueHeight(overallHeight: CGFloat) -> CGFloat {
        yForUpperBound(height: overallHeight) - yForLowerBound(height: overallHeight)
    }
    
    func yForLowerBound(height: CGFloat) -> CGFloat {
        yFor(value: CGFloat(self.range.wrappedValue.lowerBound), height: height)
    }
    
    func yForUpperBound(height: CGFloat) -> CGFloat {
        yFor(value: CGFloat(self.range.wrappedValue.upperBound), height: height)
    }
    
    func yFor(value: CGFloat, height: CGFloat) -> CGFloat {
        (height - self.thumbSize.height * 2) * ((value - CGFloat(bounds.lowerBound)) / CGFloat(bounds.upperBound - bounds.lowerBound))
    }
}

// MARK: Views

extension VerticalRangeSlider {
    func generatedValueTrackView<ValueView: View, TrackView: InsettableShape>(geometry: GeometryProxy, valueView: ValueView, trackView: TrackView) -> some View {
        valueView
            .foregroundColor(self.valueColor)
            .frame(width: self.thickness, height: geometry.size.height)
            .mask(
                Rectangle()
                    .frame(
                        width: self.thickness,
                        height: self.clippedValue ? (self.valueHeight(overallHeight: geometry.size.height) + self.thumbSize.height) : geometry.size.height
                    )
                    .fixedSize()
                    .offset(y: self.clippedValue ? -self.valueOffset(overallHeight: geometry.size.height) : 0)
            )
            .overlay(
                trackView
                    .strokeBorder(self.trackBorderColor, lineWidth: self.trackBorderWidth)
            )
            .background(self.trackColor)
                .mask(
                    trackView.frame(width: self.thickness, height: geometry.size.height)
            )
    }
    
    func generatedThumbView<ThumbView: InsettableShape>(view: ThumbView) -> some View {
        view
            .overlay(
                view.strokeBorder(self.thumbBorderColor, lineWidth: self.thumbBorderWidth)
            )
            .frame(width: self.thumbSize.width, height:self.thumbSize.height)
            .foregroundColor(self.thumbColor)
            .shadow(color: self.thumbShadowColor, radius: self.thumbShadowRadius, x: self.thumbShadowX, y: self.thumbShadowY)
    }
}

// MARK: Inits

extension VerticalRangeSlider {
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

extension VerticalRangeSlider where TrackView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, valueView: ValueView, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: valueView, thumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where ValueView == Rectangle {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, valueView: Rectangle(), thumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where ThumbView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, valueView: ValueView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, valueView: valueView, thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where ThumbView == Capsule, ValueView == Rectangle {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: trackView, valueView: Rectangle(), thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where TrackView == Capsule, ValueView == Rectangle {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: Rectangle(), thumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where TrackView == Capsule, ThumbView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, valueView: ValueView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: valueView, thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where TrackView == Capsule, ValueView == Rectangle, ThumbView == Capsule {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, trackView: Capsule(), valueView: Rectangle(), thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

// MARK: Values

extension VerticalRangeSlider {
    var width: CGFloat {
        preferences.width ?? style.width
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

// MARK: Modifiers

public extension VerticalRangeSlider {
    @inlinable func width(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.width = length
        return copy
    }
    
    @inlinable func thickness(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thickness = length
        return copy
    }
    
    @inlinable func thumbSize(_ size: CGSize?) -> Self {
        var copy = self
        copy.preferences.thumbSize = size
        return copy
    }
    
    @inlinable func thumbColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.thumbColor = color
        return copy
    }
    
    @inlinable func thumbBorderColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.thumbBorderColor = color
        return copy
    }
    
    @inlinable func thumbBorderWidth(_ width: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thumbBorderWidth = width
        return copy
    }
    
    @inlinable func thumbShadowColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.thumbShadowColor = color
        return copy
    }

    @inlinable func thumbShadowRadius(_ radius: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thumbShadowRadius = radius
        return copy
    }

    @inlinable func thumbShadowX(_ offset: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thumbShadowX = offset
        return copy
    }

    @inlinable func thumbShadowY(_ offset: CGFloat?) -> Self {
        var copy = self
        copy.preferences.thumbShadowY = offset
        return copy
    }
    
    @inlinable func valueColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.valueColor = color
        return copy
    }
    
    @inlinable func trackColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.trackColor = color
        return copy
    }

    @inlinable func trackBorderColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.trackBorderColor = color
        return copy
    }

    @inlinable func trackBorderWidth(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.trackBorderWidth = length
        return copy
    }
    
    @inlinable func clippedValue(_ isClipped: Bool?) -> Self {
        var copy = self
        copy.preferences.clippedValue = isClipped
        return copy
    }
}

#if DEBUG

struct VerticalRangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        VerticalRangeSlider(range: .constant(0...1))
    }
}

#endif
