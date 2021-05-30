import SwiftUI

public struct VerticalValueSliderStyle<Track: View, Thumb: View>: ValueSliderStyle {
    private let track: Track
    private let thumb: Thumb
    private let thumbSize: CGSize
    private let thumbInteractiveSize: CGSize
    private let options: ValueSliderOptions

    public func makeBody(configuration: Self.Configuration) -> some View {
        let track = self.track
            .environment(\.trackValue, configuration.value.wrappedValue)
            .environment(\.valueTrackConfiguration, ValueTrackConfiguration(
                bounds: configuration.bounds,
                leadingOffset: self.thumbSize.height / 2,
                trailingOffset: self.thumbSize.height / 2)
            )
            .accentColor(.accentColor)
        
        return GeometryReader { geometry in
            ZStack {
                if self.options.contains(.interactiveTrack) {
                    track.gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gestureValue in
                                let computedValue = configuration.bounds.upperBound - valueFrom(
                                    distance: gestureValue.location.y,
                                    availableDistance: geometry.size.height,
                                    bounds: configuration.bounds,
                                    step: configuration.step,
                                    leadingOffset: self.thumbSize.height / 2,
                                    trailingOffset: self.thumbSize.height / 2
                                )
                                configuration.value.wrappedValue = computedValue
                                configuration.onEditingChanged(true)
                            }
                            .onEnded { _ in
                                configuration.onEditingChanged(false)
                            }
                    )
                } else {
                    track
                }
                
                ZStack {
                    self.thumb
                        .frame(width: self.thumbSize.width, height: self.thumbSize.height)
                }
                .frame(minWidth: self.thumbInteractiveSize.width, minHeight: self.thumbInteractiveSize.height)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height - distanceFrom(
                        value: configuration.value.wrappedValue,
                        availableDistance: geometry.size.height,
                        bounds: configuration.bounds,
                        leadingOffset: self.thumbSize.height / 2,
                        trailingOffset: self.thumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gestureValue in
                            if configuration.dragOffset.wrappedValue == nil {
                                configuration.dragOffset.wrappedValue = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value: configuration.value.wrappedValue,
                                    availableDistance: geometry.size.height,
                                    bounds: configuration.bounds,
                                    leadingOffset: self.thumbSize.height / 2,
                                    trailingOffset: self.thumbSize.height / 2
                                ))
                            }
                            
                            let computedValue = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (configuration.dragOffset.wrappedValue ?? 0)),
                                availableDistance: geometry.size.height,
                                bounds: configuration.bounds,
                                step: configuration.step,
                                leadingOffset: self.thumbSize.height / 2,
                                trailingOffset: self.thumbSize.height / 2
                            )
                            
                            configuration.value.wrappedValue = computedValue
                            configuration.onEditingChanged(true)
                        }
                        .onEnded { _ in
                            configuration.dragOffset.wrappedValue = nil
                            configuration.onEditingChanged(false)
                        }
                )
            }
            .frame(width: geometry.size.width)
        }
        .frame(minWidth: self.thumbInteractiveSize.width)
    }
    
    public init(track: Track, thumb: Thumb, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: ValueSliderOptions = .defaultOptions) {
        self.track = track
        self.thumb = thumb
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension VerticalValueSliderStyle where Track == DefaultVerticalValueTrack {
    public init(thumb: Thumb, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: ValueSliderOptions = .defaultOptions) {
        self.track = DefaultVerticalValueTrack()
        self.thumb = thumb
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension VerticalValueSliderStyle where Thumb == DefaultThumb {
    public init(track: Track, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: ValueSliderOptions = .defaultOptions) {
        self.track = track
        self.thumb = DefaultThumb()
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension VerticalValueSliderStyle where Thumb == DefaultThumb, Track == DefaultVerticalValueTrack {
    public init(thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: ValueSliderOptions = .defaultOptions) {
        self.track = DefaultVerticalValueTrack()
        self.thumb = DefaultThumb()
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

public struct DefaultVerticalValueTrack: View {
    public var body: some View {
        VerticalTrack()
            .frame(width: 3)
            .background(Color.secondary.opacity(0.25))
            .cornerRadius(1.5)
    }
}
