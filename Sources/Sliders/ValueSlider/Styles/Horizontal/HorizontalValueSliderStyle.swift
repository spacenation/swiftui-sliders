import SwiftUI

public struct HorizontalValueSliderStyle<Track: View, Thumb: View>: ValueSliderStyle {
    private let track: Track
    private let thumb: Thumb
    private let thumbSize: CGSize
    private let thumbInteractiveSize: CGSize
    private let options: ValueSliderOptions

    private func x(configuration: Self.Configuration, geometry: GeometryProxy) -> CGFloat {
        distanceFrom(
            value: configuration.value.wrappedValue,
            availableDistance: geometry.size.width,
            bounds: configuration.bounds,
            leadingOffset: thumbSize.width / 2,
            trailingOffset: thumbSize.width / 2
        )
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        let prominentGesture = configuration.thumbGestureState.wrappedValue ?? configuration.trackGestureState.wrappedValue
        let track = self.track
            .environment(\.trackValue, configuration.value.wrappedValue)
            .environment(\.valueTrackConfiguration, ValueTrackConfiguration(
                bounds: configuration.bounds,
                leadingOffset: self.thumbSize.width / 2,
                trailingOffset: self.thumbSize.width / 2)
            )
            .accentColor(Color.accentColor)

        return GeometryReader { geometry in
            ZStack {
                if self.options.contains(.interactiveTrack) {
                    track.gesture(
                        DragGesture(minimumDistance: 0)
                            .updating(configuration.trackGestureState) { value, state, transaction in
                                state = (state ?? SliderGestureState(initialOffset: 0)).updating(
                                    with: value.location.x,
                                    speed: configuration.precisionScrubbing.scrubValue(Float(value.translation.height))
                                )
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
                    x: x(configuration: configuration, geometry: geometry),
                    y: geometry.size.height / 2
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .updating(configuration.thumbGestureState) { value, state, transaction in
                            state = (state ?? {
                                let x = x(configuration: configuration, geometry: geometry)
                                return SliderGestureState(initialOffset: value.location.x - x)
                            }()).updating(
                                with: value.location.x,
                                speed: configuration.precisionScrubbing.scrubValue(Float(value.translation.height))
                            )
                        }
                )
            }
            .frame(height: geometry.size.height)
            .onChange(of: prominentGesture) { state in
                guard let state else { return }

                configuration.value.wrappedValue = valueFrom(
                    distance: state.offset - (configuration.dragOffset.wrappedValue ?? 0),
                    availableDistance: geometry.size.width,
                    bounds: configuration.bounds,
                    step: configuration.step,
                    leadingOffset: self.thumbSize.width / 2,
                    trailingOffset: self.thumbSize.width / 2
                )
            }
            .onChange(of: prominentGesture != nil) { editing in
                configuration.onEditingChanged(editing)
            }
            .onChange(of: prominentGesture?.speed) { speed in
                configuration.precisionScrubbing.onChange?(speed)
            }
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
    public init() {}
    public var body: some View {
        HorizontalTrack()
            .frame(height: 3)
            .background(Color.secondary.opacity(0.25))
            .cornerRadius(1.5)
    }
}
