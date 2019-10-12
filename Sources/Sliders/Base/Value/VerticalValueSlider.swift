import SwiftUI

public typealias VSlider = VerticalValueSlider

public struct VerticalValueSlider<V, TrackView: View, ThumbView : View>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let value: Binding<V>
    let bounds: ClosedRange<CGFloat>
    let step: CGFloat
    let track: AnyView
    let thumbView: AnyView
    let thumbSize: CGSize
    let thumbInteractiveSize: CGSize
    
    let onEditingChanged: (Bool) -> Void
    
    @State
    private var dragOffset: CGFloat? = nil
    
    public var body: some View {
        let value = CGFloat(self.value.wrappedValue)
        
        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.track
                
                ZStack {
                    self.thumbView
                        .frame(width: self.thumbSize.width, height: self.thumbSize.height)
                }
                .frame(minWidth: self.thumbInteractiveSize.width, minHeight: self.thumbInteractiveSize.height)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height - distanceFrom(
                        value: value,
                        availableDistance: geometry.size.height,
                        bounds: self.bounds,
                        leadingOffset: self.thumbSize.height / 2,
                        trailingOffset: self.thumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if self.dragOffset == nil {
                                self.dragOffset = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value: value,
                                    availableDistance: geometry.size.height,
                                    bounds: self.bounds,
                                    leadingOffset: self.thumbSize.height / 2,
                                    trailingOffset: self.thumbSize.height / 2
                                ))
                            }
                            
                            let computedValue = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (self.dragOffset ?? 0)),
                                availableDistance: geometry.size.height,
                                bounds: self.bounds,
                                step: self.step,
                                leadingOffset: self.thumbSize.height / 2,
                                trailingOffset: self.thumbSize.height / 2
                            )
                            
                            self.value.wrappedValue = V(computedValue)
                            self.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            self.dragOffset = nil
                            self.onEditingChanged(false)
                        }
                )
            }
            /// If opacity is zero gesture is never called.
            .background(Color.white.opacity(0.00000000001))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gestureValue in
                        let computedValue = self.bounds.upperBound - valueFrom(
                            distance: gestureValue.location.y,
                            availableDistance: geometry.size.height,
                            bounds: self.bounds,
                            step: self.step,
                            leadingOffset: self.thumbSize.height / 2,
                            trailingOffset: self.thumbSize.height / 2
                        )
                        self.value.wrappedValue = V(computedValue)
                        self.onEditingChanged(true)
                    }
                    .onEnded { _ in
                        self.onEditingChanged(false)
                    }
            )
        }
        .frame(minWidth: self.thumbInteractiveSize.width)
    }
}

// MARK: Inits

extension VerticalValueSlider {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, thumb: ThumbView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.value = value
        self.bounds = CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound)
        self.step = CGFloat(step)
        self.track = AnyView(track)
        self.thumbView = AnyView(thumb)
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.onEditingChanged = onEditingChanged
    }
}

extension VerticalValueSlider where TrackView == DefaultVerticalValueTrack<V>, ThumbView == DefaultThumb {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        let track = DefaultVerticalValueTrack(
            value: value.wrappedValue,
            in: bounds,
            leadingOffset: thumbSize.height / 2,
            trailingOffset: thumbSize.height / 2
        )
        self.init(value: value, in: bounds, step: step, track: track, thumb: DefaultThumb(), thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

extension VerticalValueSlider where ThumbView == DefaultThumb {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, track: TrackView, thumbSize: CGSize = .defaultThumbSize, thumbInteractiveSize: CGSize = .defaultThumbInteractiveSize, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(value: value, in: bounds, step: step, track: track, thumb: DefaultThumb(), thumbSize: thumbSize, thumbInteractiveSize: thumbInteractiveSize, onEditingChanged: onEditingChanged)
    }
}

#if DEBUG
struct VerticalValueSlider_Previews: PreviewProvider {
    static var previews: some View {
        VerticalValueSlider(value: .constant(0.5))
            .previewLayout(.fixed(width: 100, height: 300))
    }
}
#endif
