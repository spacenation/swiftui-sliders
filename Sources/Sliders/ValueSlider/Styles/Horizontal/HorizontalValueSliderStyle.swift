import SwiftUI

public struct HorizontalValueSliderStyle<Track: View, Thumb: View>: ValueSliderStyle {
    private let track: Track
    private let thumb: Thumb
    private let thumbSize: CGSize
    private let thumbInteractiveSize: CGSize
    private let options: ValueSliderOptions

    public func makeBody(configuration: Self.Configuration) -> some View {
        let track = self.track
            .environment(\.trackValue, configuration.value.wrappedValue)
            .environment(\.trackConfiguration, ValueTrackConfiguration(
                bounds: configuration.bounds,
                leadingOffset: self.thumbSize.width / 2,
                trailingOffset: self.thumbSize.width / 2)
            )
            .accentColor(.accentColor)
        
        return GeometryReader { geometry in
            ZStack {
                if self.options.contains(.interactiveTrack) {
                    track.gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gestureValue in
                                let computedValue = valueFrom(
                                    distance: gestureValue.location.x,
                                    availableDistance: geometry.size.width,
                                    bounds: configuration.bounds,
                                    step: configuration.step,
                                    leadingOffset: self.thumbSize.width / 2,
                                    trailingOffset: self.thumbSize.width / 2
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
                    x: distanceFrom(
                        value: configuration.value.wrappedValue,
                        availableDistance: geometry.size.width,
                        bounds: configuration.bounds,
                        leadingOffset: self.thumbSize.width / 2,
                        trailingOffset: self.thumbSize.width / 2
                    ),
                    y: geometry.size.height / 2
                )
                .gesture(
                    DragGesture()
                        .onChanged { gestureValue in
                            if configuration.dragOffset.wrappedValue == nil {
                                configuration.dragOffset.wrappedValue = gestureValue.startLocation.x - distanceFrom(
                                    value: configuration.value.wrappedValue,
                                    availableDistance: geometry.size.width,
                                    bounds: configuration.bounds,
                                    leadingOffset: self.thumbSize.width / 2,
                                    trailingOffset: self.thumbSize.width / 2
                                )
                            }

                            let computedValue = valueFrom(
                                distance: gestureValue.location.x - (configuration.dragOffset.wrappedValue ?? 0),
                                availableDistance: geometry.size.width,
                                bounds: configuration.bounds,
                                step: configuration.step,
                                leadingOffset: self.thumbSize.width / 2,
                                trailingOffset: self.thumbSize.width / 2
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
            .frame(height: geometry.size.height)
        }
        .frame(minHeight: self.thumbInteractiveSize.height)
    }
    
    public init(track: Track, thumb: Thumb, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: ValueSliderOptions = .defaultOptions) {
        self.track = track
        self.thumb = thumb
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension HorizontalValueSliderStyle where Track == DefaultHorizontalValueTrack {
    public init(thumb: Thumb, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: ValueSliderOptions = .defaultOptions) {
        self.track = DefaultHorizontalValueTrack()
        self.thumb = thumb
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension HorizontalValueSliderStyle where Thumb == DefaultThumb {
    public init(track: Track, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: ValueSliderOptions = .defaultOptions) {
        self.track = track
        self.thumb = DefaultThumb()
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension HorizontalValueSliderStyle where Thumb == DefaultThumb, Track == DefaultHorizontalValueTrack {
    public init(thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: ValueSliderOptions = .defaultOptions) {
        self.track = DefaultHorizontalValueTrack()
        self.thumb = DefaultThumb()
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

public struct DefaultHorizontalValueTrack: View {
    public var body: some View {
        HorizontalTrack()
            .frame(height: 3)
            .background(Color.secondary.opacity(0.25))
            .cornerRadius(1.5)
    }
}
