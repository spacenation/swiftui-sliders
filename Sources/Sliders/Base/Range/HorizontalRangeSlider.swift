import SwiftUI

public typealias HRangeSlider = HorizontalRangeSlider

public struct HorizontalRangeSlider<V, TrackView: View, LowerThumbView: View, UpperThumbView: View> : View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: Binding<ClosedRange<V>>
    let bounds: ClosedRange<CGFloat>
    let step: CGFloat
    
    let track: AnyView
    
    let lowerThumb: AnyView
    let upperThumb: AnyView
    
    let lowerThumbSize: CGSize
    let upperThumbSize: CGSize
    
    let lowerThumbInteractiveSize: CGSize
    let upperThumbInteractiveSize: CGSize
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffset: CGFloat? = nil

    public var body: some View {
        let range = CGFloat(self.range.wrappedValue.lowerBound)...CGFloat(self.range.wrappedValue.upperBound)
        
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                self.track
                
                ZStack {
                    self.lowerThumb
                        .frame(width: self.lowerThumbSize.width, height: self.lowerThumbSize.height)
                }
                .frame(minWidth: self.lowerThumbInteractiveSize.width, minHeight: self.lowerThumbInteractiveSize.height)
                .position(
                    x: distanceFrom(
                        value: range.lowerBound,
                        availableDistance: geometry.size.width - self.upperThumbSize.width,
                        bounds: self.bounds,
                        leadingOffset: self.lowerThumbSize.width / 2,
                        trailingOffset: self.lowerThumbSize.width / 2
                    ),
                    y: geometry.size.height / 2
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                self.dragOffset = gestureValue.startLocation.x - distanceFrom(
                                    value: range.lowerBound,
                                    availableDistance: geometry.size.width - self.upperThumbSize.width,
                                    bounds: self.bounds,
                                    leadingOffset: self.lowerThumbSize.width / 2,
                                    trailingOffset: self.lowerThumbSize.width / 2
                                )
                            }
                            
                            let computedLowerBound = valueFrom(
                                distance: gestureValue.location.x - (self.dragOffset ?? 0),
                                availableDistance: geometry.size.width - self.upperThumbSize.width,
                                bounds: self.bounds,
                                step: self.step,
                                leadingOffset: self.lowerThumbSize.width / 2,
                                trailingOffset: self.lowerThumbSize.width / 2
                            )
                            
                            let computedUpperBound = max(computedLowerBound, CGFloat(self.range.wrappedValue.upperBound))
                            self.range.wrappedValue = V(computedLowerBound)...V(computedUpperBound)
                            self.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            self.dragOffset = nil
                            self.onEditingChanged(false)
                        }
                )

                ZStack {
                    self.upperThumb
                        .frame(width: self.upperThumbSize.width, height: self.upperThumbSize.height)
                }
                .frame(minWidth: self.upperThumbInteractiveSize.width, minHeight: self.upperThumbInteractiveSize.height)
                .position(
                    x: distanceFrom(
                        value: range.upperBound,
                        availableDistance: geometry.size.width,
                        bounds: self.bounds,
                        leadingOffset: self.lowerThumbSize.width + self.upperThumbSize.width / 2,
                        trailingOffset: self.upperThumbSize.width / 2
                    ),
                    y: geometry.size.height / 2
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                self.dragOffset = gestureValue.startLocation.x - distanceFrom(
                                    value: range.upperBound,
                                    availableDistance: geometry.size.width,
                                    bounds: self.bounds,
                                    leadingOffset: self.lowerThumbSize.width + self.upperThumbSize.width / 2,
                                    trailingOffset: self.upperThumbSize.width / 2
                                )
                            }
                            
                            let computedUpperBound = valueFrom(
                                distance: gestureValue.location.x - (self.dragOffset ?? 0),
                                availableDistance: geometry.size.width,
                                bounds: self.bounds,
                                step: self.step,
                                leadingOffset: self.lowerThumbSize.width + self.upperThumbSize.width / 2,
                                trailingOffset: self.upperThumbSize.width / 2
                            )
                            
                            let computedLowerBound = min(computedUpperBound, CGFloat(self.range.wrappedValue.lowerBound))
                            self.range.wrappedValue = V(computedLowerBound)...V(computedUpperBound)
                            self.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            self.dragOffset = nil
                            self.onEditingChanged(false)
                        }
                )
            }
        }
        .frame(minHeight: max(self.lowerThumbInteractiveSize.height, self.upperThumbInteractiveSize.height))
    }
}

// MARK: Inits

extension HorizontalRangeSlider {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 0.001, track: TrackView, lowerThumb: LowerThumbView, upperThumb: UpperThumbView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.range = range
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.step = CGFloat(step)

        self.track = AnyView(track)
        self.lowerThumb = AnyView(lowerThumb)
        self.upperThumb = AnyView(upperThumb)
        
        self.lowerThumbSize = thumbSize
        self.upperThumbSize = thumbSize
        
        self.lowerThumbInteractiveSize = thumbInteractiveSize
        self.upperThumbInteractiveSize = thumbInteractiveSize

        self.onEditingChanged = onEditingChanged
    }
}

extension HorizontalRangeSlider where TrackView == DefaultHorizontalRangeTrack<V> {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, lowerThumb: LowerThumbView, upperThumb: UpperThumbView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        
        let track = DefaultHorizontalRangeTrack(
            range: range.wrappedValue,
            in: bounds,
            lowerLeadingOffset: thumbSize.width / 2,
            lowerTrailingOffset: thumbSize.width / 2 + thumbSize.width,
            upperLeadingOffset: thumbSize.width + thumbSize.width / 2,
            upperTrailingOffset: thumbSize.width / 2
        )
        
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: lowerThumb, upperThumb: upperThumb, thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

extension HorizontalRangeSlider where LowerThumbView == DefaultThumb, UpperThumbView == DefaultThumb {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: DefaultThumb(), upperThumb: DefaultThumb(), thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

extension HorizontalRangeSlider where TrackView == DefaultHorizontalRangeTrack<V>, LowerThumbView == DefaultThumb, UpperThumbView == DefaultThumb {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        
        let track = DefaultHorizontalRangeTrack(
            range: range.wrappedValue,
            in: bounds,
            lowerLeadingOffset: thumbSize.width / 2,
            lowerTrailingOffset: thumbSize.width / 2 + thumbSize.width,
            upperLeadingOffset: thumbSize.width + thumbSize.width / 2,
            upperTrailingOffset: thumbSize.width / 2
        )
        
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: DefaultThumb(), upperThumb: DefaultThumb(), thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

// MARK: Inits for same LowerThumbView and UpperThumbView

extension HorizontalRangeSlider where LowerThumbView == UpperThumbView {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, thumb: LowerThumbView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: thumb, upperThumb: thumb, thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

extension HorizontalRangeSlider where TrackView == DefaultHorizontalRangeTrack<V>, LowerThumbView == UpperThumbView {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumb: LowerThumbView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        
        let track = DefaultHorizontalRangeTrack(
            range: range.wrappedValue,
            in: bounds,
            lowerLeadingOffset: thumbSize.width / 2,
            lowerTrailingOffset: thumbSize.width / 2 + thumbSize.width,
            upperLeadingOffset: thumbSize.width + thumbSize.width / 2,
            upperTrailingOffset: thumbSize.width / 2
        )
        
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: thumb, upperThumb: thumb, thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

#if DEBUG

struct HorizontalRangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalRangeSlider(range: .constant(0...1))
    }
}

#endif
