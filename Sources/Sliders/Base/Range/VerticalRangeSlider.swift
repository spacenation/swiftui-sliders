import SwiftUI

public typealias VRangeSlider = VerticalRangeSlider

public struct VerticalRangeSlider<V, TrackView: View, LowerThumbView: View, UpperThumbView: View> : View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
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
            ZStack {
                self.track
                
                ZStack {
                    self.lowerThumb
                        .frame(width: self.lowerThumbSize.width, height: self.lowerThumbSize.height)
                }
                .frame(minWidth: self.lowerThumbInteractiveSize.width, minHeight: self.lowerThumbInteractiveSize.height)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height - distanceFrom(
                        value: range.lowerBound,
                        availableDistance: geometry.size.height - self.upperThumbSize.height,
                        bounds: self.bounds,
                        leadingOffset: self.lowerThumbSize.height / 2,
                        trailingOffset: self.lowerThumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                self.dragOffset = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value: range.lowerBound,
                                    availableDistance: geometry.size.height - self.upperThumbSize.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.lowerThumbSize.height / 2,
                                    trailingOffset: self.lowerThumbSize.height / 2
                                ))
                            }
                            
                            let computedLowerBound = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (self.dragOffset ?? 0)),
                                availableDistance: geometry.size.height - self.upperThumbSize.height,
                                bounds: self.bounds,
                                step: self.step,
                                leadingOffset: self.lowerThumbSize.height / 2,
                                trailingOffset: self.lowerThumbSize.height / 2
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
                    x: geometry.size.width / 2,
                    y: geometry.size.height - distanceFrom(
                        value: range.upperBound,
                        availableDistance: geometry.size.height,
                        bounds: self.bounds,
                        leadingOffset: self.lowerThumbSize.height + self.upperThumbSize.height / 2,
                        trailingOffset: self.upperThumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                self.dragOffset = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value: range.upperBound,
                                    availableDistance: geometry.size.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.lowerThumbSize.height + self.upperThumbSize.height / 2,
                                    trailingOffset: self.upperThumbSize.height / 2
                                ))
                            }
                            
                            let computedUpperBound = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (self.dragOffset ?? 0)),
                                availableDistance: geometry.size.height,
                                bounds: self.bounds,
                                step: self.step,
                                leadingOffset: self.lowerThumbSize.height + self.upperThumbSize.height / 2,
                                trailingOffset: self.upperThumbSize.height / 2
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
        .frame(minWidth: max(self.lowerThumbInteractiveSize.width, self.upperThumbInteractiveSize.width))
    }
}

// MARK: Inits

extension VerticalRangeSlider {
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

extension VerticalRangeSlider where TrackView == DefaultVerticalRangeTrack<V> {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, lowerThumb: LowerThumbView, upperThumb: UpperThumbView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        
        let track = DefaultVerticalRangeTrack(
            range: range.wrappedValue,
            in: bounds,
            lowerLeadingOffset: thumbSize.height / 2,
            lowerTrailingOffset: thumbSize.height / 2 + thumbSize.height,
            upperLeadingOffset: thumbSize.height + thumbSize.height / 2,
            upperTrailingOffset: thumbSize.height / 2
        )
        
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: lowerThumb, upperThumb: upperThumb, thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where LowerThumbView == DefaultThumb, UpperThumbView == DefaultThumb {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: DefaultThumb(), upperThumb: DefaultThumb(), thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where TrackView == DefaultVerticalRangeTrack<V>, LowerThumbView == DefaultThumb, UpperThumbView == DefaultThumb {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        
        let track = DefaultVerticalRangeTrack(
            range: range.wrappedValue,
            in: bounds,
            lowerLeadingOffset: thumbSize.height / 2,
            lowerTrailingOffset: thumbSize.height / 2 + thumbSize.height,
            upperLeadingOffset: thumbSize.height + thumbSize.height / 2,
            upperTrailingOffset: thumbSize.height / 2
        )
        
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: DefaultThumb(), upperThumb: DefaultThumb(), thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

// MARK: Inits for same LowerThumbView and UpperThumbView

extension VerticalRangeSlider where LowerThumbView == UpperThumbView {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, thumb: LowerThumbView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: thumb, upperThumb: thumb, thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

extension VerticalRangeSlider where TrackView == DefaultVerticalRangeTrack<V>, LowerThumbView == UpperThumbView {
    public init(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumb: LowerThumbView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        
        let track = DefaultVerticalRangeTrack(
            range: range.wrappedValue,
            in: bounds,
            lowerLeadingOffset: thumbSize.height / 2,
            lowerTrailingOffset: thumbSize.height / 2 + thumbSize.height,
            upperLeadingOffset: thumbSize.height + thumbSize.height / 2,
            upperTrailingOffset: thumbSize.height / 2
        )
        
        self.init(range: range, in: bounds, step: step, track: track, lowerThumb: thumb, upperThumb: thumb, thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

#if DEBUG

struct VerticalRangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        VerticalRangeSlider(range: .constant(0...1))
    }
}

#endif
