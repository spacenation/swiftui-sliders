import SwiftUI

public struct RectangularPointSliderStyle<Track: View, Thumb: View>: PointSliderStyle {
    private let track: Track
    private let thumb: Thumb
    private let thumbSize: CGSize
    private let thumbInteractiveSize: CGSize
    private let options: PointSliderOptions

    public func makeBody(configuration: Self.Configuration) -> some View {
        let track = self.track
            .environment(\.trackPointX, configuration.x.wrappedValue)
            .environment(\.trackPointY, configuration.y.wrappedValue)
            .environment(\.pointTrackConfiguration, PointTrackConfiguration(
                xBounds: configuration.xBounds,
                xStep: configuration.xStep,
                yBounds: configuration.yBounds,
                yStep: configuration.yStep
            ))
            .accentColor(Color.accentColor)

        return GeometryReader { geometry in
            ZStack {
                if self.options.contains(.interactiveTrack) {
                    track.gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gestureValue in
                                configuration.onEditingChanged(true)

                                let computedValueX = valueFrom(
                                    distance: gestureValue.location.x,
                                    availableDistance: geometry.size.width,
                                    bounds: configuration.xBounds,
                                    step: configuration.xStep,
                                    leadingOffset: self.thumbSize.width / 2,
                                    trailingOffset: self.thumbSize.width / 2
                                )

                                let computedValueY = configuration.yBounds.upperBound - valueFrom(
                                    distance: gestureValue.location.y,
                                    availableDistance: geometry.size.height,
                                    bounds: configuration.yBounds,
                                    step: configuration.yStep,
                                    leadingOffset: self.thumbSize.height / 2,
                                    trailingOffset: self.thumbSize.height / 2
                                )

                                configuration.x.wrappedValue = computedValueX
                                configuration.y.wrappedValue = computedValueY
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
                        value: configuration.x.wrappedValue,
                        availableDistance: geometry.size.width,
                        bounds: configuration.xBounds,
                        leadingOffset: self.thumbSize.width / 2,
                        trailingOffset: self.thumbSize.width / 2
                    ),
                    y: geometry.size.height - distanceFrom(
                        value: configuration.y.wrappedValue,
                        availableDistance: geometry.size.height,
                        bounds: configuration.yBounds,
                        leadingOffset: self.thumbSize.height / 2,
                        trailingOffset: self.thumbSize.height / 2
                    )
                )
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gestureValue in
                            configuration.onEditingChanged(true)

                            if configuration.dragOffset.wrappedValue == nil {
                                let gragOffsetX = gestureValue.startLocation.x - distanceFrom(
                                    value: configuration.x.wrappedValue,
                                    availableDistance: geometry.size.width,
                                    bounds: configuration.xBounds,
                                    leadingOffset: self.thumbSize.width / 2,
                                    trailingOffset: self.thumbSize.width / 2
                                )

                                let dragOffsetY = gestureValue.startLocation.y - (geometry.size.height - distanceFrom(
                                    value:  configuration.y.wrappedValue,
                                    availableDistance: geometry.size.height,
                                    bounds: configuration.yBounds,
                                    leadingOffset: self.thumbSize.height / 2,
                                    trailingOffset: self.thumbSize.height / 2
                                ))

                                configuration.dragOffset.wrappedValue = CGPoint(x: gragOffsetX, y: dragOffsetY)
                            }

                            let computedValueX = valueFrom(
                                distance: gestureValue.location.x - (configuration.dragOffset.wrappedValue?.x ?? 0),
                                availableDistance: geometry.size.width,
                                bounds: configuration.xBounds,
                                step: configuration.xStep,
                                leadingOffset: self.thumbSize.width / 2,
                                trailingOffset: self.thumbSize.width / 2
                            )

                            let computedValueY = valueFrom(
                                distance: geometry.size.height - (gestureValue.location.y - (configuration.dragOffset.wrappedValue?.y ?? 0)),
                                availableDistance: geometry.size.height,
                                bounds: configuration.yBounds,
                                step: configuration.yStep,
                                leadingOffset: self.thumbSize.height / 2,
                                trailingOffset: self.thumbSize.height / 2
                            )

                            configuration.x.wrappedValue = computedValueX
                            configuration.y.wrappedValue = computedValueY
                        }
                        .onEnded { _ in
                            configuration.dragOffset.wrappedValue = nil
                            configuration.onEditingChanged(false)
                        }
                )

            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .frame(minWidth: self.thumbInteractiveSize.width, minHeight: self.thumbInteractiveSize.height)
    }

    public init(track: Track, thumb: Thumb, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: PointSliderOptions = .defaultOptions) {
        self.track = track
        self.thumb = thumb
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension RectangularPointSliderStyle where Track == DefaultRectangularPointTrack {
    public init(thumb: Thumb, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: PointSliderOptions = .defaultOptions) {
        self.track = DefaultRectangularPointTrack()
        self.thumb = thumb
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension RectangularPointSliderStyle where Thumb == DefaultThumb {
    public init(track: Track, thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: PointSliderOptions = .defaultOptions) {
        self.track = track
        self.thumb = DefaultThumb()
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

extension RectangularPointSliderStyle where Thumb == DefaultThumb, Track == DefaultRectangularPointTrack {
    public init(thumbSize: CGSize = CGSize(width: 27, height: 27), thumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: PointSliderOptions = .defaultOptions) {
        self.track = DefaultRectangularPointTrack()
        self.thumb = DefaultThumb()
        self.thumbSize = thumbSize
        self.thumbInteractiveSize = thumbInteractiveSize
        self.options = options
    }
}

public struct DefaultRectangularPointTrack: View {
    public var body: some View {
        Rectangle()
            .foregroundColor(Color.accentColor)
    }
}
