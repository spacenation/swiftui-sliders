import SwiftUI

public typealias HSlider = HorizontalValueSlider

public struct HorizontalValueSlider<V, TrackView: View, ThumbView : InsettableShape>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    @Environment(\.sliderStyle)
    var style
    
    @usableFromInline
    var preferences = SliderPreferences()
    
    let value: Binding<V>
    let bounds: ClosedRange<V>
    let step: V.Stride

    let trackView: TrackView
    let thumbView: ThumbView
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffsetX: CGFloat? = nil
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.trackView
                    .frame(width: geometry.size.width, height: self.thickness)
                    .trackStyle(
                        CustomTrackStyle(
                            valueColor: self.valueColor,
                            backgroundColor: self.trackColor,
                            borderColor: self.trackBorderColor,
                            borderWidth: self.trackBorderWidth,
                            startOffset: self.thumbSize.width / 2,
                            endOffset: self.thumbSize.width / 2
                        )
                    )
                
                self.thumbView
                    .overlay(
                        self.thumbView.strokeBorder(self.thumbBorderColor, lineWidth: self.thumbBorderWidth)
                    )
                    .frame(width: self.thumbSize.width, height: self.thumbSize.height)
                    .fixedSize()
                    .foregroundColor(self.thumbColor)
                    .shadow(color:self.thumbShadowColor, radius: self.thumbShadowRadius, x: self.thumbShadowX, y: self.thumbShadowY)
                    .offset(x: offsetFromCenterToValue(
                        overallLength: geometry.size.width - self.thumbSize.width,
                        value: CGFloat(self.value.wrappedValue),
                        bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                    ))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                                let availableLength = geometry.size.width - self.thumbSize.width
                                
                                if self.dragOffsetX == nil {
                                    let computedValueOffset = offsetFromCenterToValue(
                                        overallLength: availableLength,
                                        value: CGFloat(self.value.wrappedValue),
                                        bounds: bounds
                                    )
                                    self.dragOffsetX = value.startLocation.x - computedValueOffset
                                }
                                
                                let locationOffset = value.location.x - (self.dragOffsetX ?? 0)
                                let relativeValue = relativeValueFrom(overallLength: availableLength, centerOffset: locationOffset)
                                let computedValue = valueFrom(relativeValue: relativeValue, bounds: bounds, step: CGFloat(self.step))
                                self.value.wrappedValue = V(computedValue)
                                self.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                self.dragOffsetX = nil
                                self.onEditingChanged(false)
                            }
                    )
            }
            .frame(height: self.height)
            /// If opacity is zero gesture is never called.
            .background(Color.white.opacity(0.00000000001))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        /// Coordinates here are not offset from center.
                        let relativeValue: CGFloat = (value.location.x - self.thumbSize.width / 2) / (geometry.size.width - self.thumbSize.width)
                        let bounds = CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound)
                        let computedValue = valueFrom(relativeValue: relativeValue, bounds: bounds, step: CGFloat(self.step))
                        self.value.wrappedValue = V(computedValue)
                        self.onEditingChanged(true)
                    }
                    .onEnded { _ in
                        self.onEditingChanged(false)
                    }
            )
        }
        .frame(height: self.height)
        
        /// Enabling this draws incorrect gradient on value change, fix it before enabling metal randering
        //.drawingGroup()
    }
}

// MARK: Inits

extension HorizontalValueSlider {
    /// Creates an instance that selects a value from within a range.
    ///
    /// - Parameters:
    ///     - value: The selected value within `bounds`.
    ///     - bounds: The range of the valid values. Defaults to `0...1`.
    ///     - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// `onEditingChanged` will be called when editing begins and ends. For
    /// example, on iOS, a `RangeSlider` is considered to be actively editing while
    /// the user is touching the thumb and sliding it around the track.
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.value = value
        self.bounds = bounds
        self.step = step
        
        self.trackView = trackView
        
        //self.trackShape = trackShape
        //self.valueView = valueView
        self.thumbView = thumbView
        
        self.onEditingChanged = onEditingChanged
    }
}

extension HorizontalValueSlider where TrackView == HorizontalValueTrack<V, Capsule, Capsule> {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbView: ThumbView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let horizontalTrackView = HorizontalValueTrack(value: value.wrappedValue, in: bounds)
        self.init(value: value, in: bounds, step: step, trackView: horizontalTrackView, thumbView: thumbView, onEditingChanged: onEditingChanged)
    }
}

extension HorizontalValueSlider where ThumbView == Capsule {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, trackView: TrackView, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, trackView: trackView, thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

extension HorizontalValueSlider where TrackView == HorizontalValueTrack<V, Capsule, Capsule>, ThumbView == Capsule {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let horizontalTrackView = HorizontalValueTrack(value: value.wrappedValue, in: bounds)
        self.init(value: value, in: bounds, step: step, trackView: horizontalTrackView, thumbView: Capsule(), onEditingChanged: onEditingChanged)
    }
}

// MARK: Values

extension HorizontalValueSlider {
    var height: CGFloat {
        preferences.height ?? style.height
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
}

// MARK: Modifiers

public extension HorizontalValueSlider {
    @inlinable func height(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.height = length
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
}


#if DEBUG
struct  HorizontalValueSlider_Previews: PreviewProvider {
    
    static var previews: some View {
        HorizontalValueSlider(value: .constant(0.5), thumbView: Rectangle())
            .height(100)
            .thumbColor(.blue)
            .thumbBorderWidth(4)
            .thumbBorderColor(.red)
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
#endif
