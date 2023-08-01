import SwiftUI

public struct HorizontalRangeSliderStyle<Track: View, LowerThumb: View, UpperThumb: View>: RangeSliderStyle {
    private let track: Track
    private let lowerThumb: LowerThumb
    private let upperThumb: UpperThumb

    let lowerThumbSize: CGSize
    let upperThumbSize: CGSize

    let lowerThumbInteractiveSize: CGSize
    let upperThumbInteractiveSize: CGSize

    private let options: RangeSliderOptions

    let onSelectLower: () -> Void
    let onSelectUpper: () -> Void

    public func makeBody(configuration: Self.Configuration) -> some View {
        GeometryReader { geometry in
            ZStack {
                self.track
                    .environment(\.trackRange, configuration.range.wrappedValue)
                    .environment(\.rangeTrackConfiguration, RangeTrackConfiguration(
                        bounds: configuration.bounds,
                        lowerLeadingOffset: self.lowerThumbSize.width / 2,
                        lowerTrailingOffset: self.lowerThumbSize.width / 2 + self.upperThumbSize.width,
                        upperLeadingOffset: self.lowerThumbSize.width + self.upperThumbSize.width / 2,
                        upperTrailingOffset: self.upperThumbSize.width / 2
                    ))
                    .accentColor(Color.accentColor)

                ZStack {
                    self.lowerThumb
                        .frame(width: self.lowerThumbSize.width, height: self.lowerThumbSize.height)
                }
                .frame(minWidth: self.lowerThumbInteractiveSize.width, minHeight: self.lowerThumbInteractiveSize.height)
                .position(
                    x: distanceFrom(
                        value: configuration.range.wrappedValue.lowerBound,
                        availableDistance: geometry.size.width - self.upperThumbSize.width,
                        bounds: configuration.bounds,
                        leadingOffset: self.lowerThumbSize.width / 2,
                        trailingOffset: self.lowerThumbSize.width / 2
                    ),
                    y: geometry.size.height / 2
                )
                .gesture(
                    SimultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gestureValue in
                                configuration.onEditingChanged(true)

                                self.onSelectLower()

                                if configuration.dragOffset.wrappedValue == nil {
                                    configuration.dragOffset.wrappedValue = gestureValue.startLocation.x - distanceFrom(
                                        value: configuration.range.wrappedValue.lowerBound,
                                        availableDistance: geometry.size.width - self.upperThumbSize.width,
                                        bounds: configuration.bounds,
                                        leadingOffset: self.lowerThumbSize.width / 2,
                                        trailingOffset: self.lowerThumbSize.width / 2
                                    )
                                }

                                let computedLowerBound = valueFrom(
                                    distance: gestureValue.location.x - (configuration.dragOffset.wrappedValue ?? 0),
                                    availableDistance: geometry.size.width - self.upperThumbSize.width,
                                    bounds: configuration.bounds,
                                    step: configuration.step,
                                    leadingOffset: self.lowerThumbSize.width / 2,
                                    trailingOffset: self.lowerThumbSize.width / 2
                                )

                                configuration.range.wrappedValue = rangeFrom(
                                    updatedLowerBound: computedLowerBound,
                                    upperBound: configuration.range.wrappedValue.upperBound,
                                    bounds: configuration.bounds,
                                    distance: configuration.distance,
                                    forceAdjacent: options.contains(.forceAdjacentValue)
                                )
                            }
                            .onEnded { _ in
                                configuration.dragOffset.wrappedValue = nil
                                configuration.onEditingChanged(false)
                            },
                        TapGesture()
                            .onEnded { _ in
                                self.onSelectLower()
                            }
                    )
                )

                ZStack {
                    self.upperThumb
                        .frame(width: self.upperThumbSize.width, height: self.upperThumbSize.height)
                }
                .frame(minWidth: self.upperThumbInteractiveSize.width, minHeight: self.upperThumbInteractiveSize.height)
                .position(
                    x: distanceFrom(
                        value: configuration.range.wrappedValue.upperBound,
                        availableDistance: geometry.size.width,
                        bounds: configuration.bounds,
                        leadingOffset: self.lowerThumbSize.width + self.upperThumbSize.width / 2,
                        trailingOffset: self.upperThumbSize.width / 2
                    ),
                    y: geometry.size.height / 2
                )
                .gesture(
                    SimultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gestureValue in
                                configuration.onEditingChanged(true)

                                self.onSelectUpper()

                                if configuration.dragOffset.wrappedValue == nil {
                                    configuration.dragOffset.wrappedValue = gestureValue.startLocation.x - distanceFrom(
                                        value: configuration.range.wrappedValue.upperBound,
                                        availableDistance: geometry.size.width,
                                        bounds: configuration.bounds,
                                        leadingOffset: self.lowerThumbSize.width + self.upperThumbSize.width / 2,
                                        trailingOffset: self.upperThumbSize.width / 2
                                    )
                                }

                                let computedUpperBound = valueFrom(
                                    distance: gestureValue.location.x - (configuration.dragOffset.wrappedValue ?? 0),
                                    availableDistance: geometry.size.width,
                                    bounds: configuration.bounds,
                                    step: configuration.step,
                                    leadingOffset: self.lowerThumbSize.width + self.upperThumbSize.width / 2,
                                    trailingOffset: self.upperThumbSize.width / 2
                                )

                                configuration.range.wrappedValue = rangeFrom(
                                    lowerBound: configuration.range.wrappedValue.lowerBound,
                                    updatedUpperBound: computedUpperBound,
                                    bounds: configuration.bounds,
                                    distance: configuration.distance,
                                    forceAdjacent: options.contains(.forceAdjacentValue)
                                )
                            }
                            .onEnded { _ in
                                configuration.dragOffset.wrappedValue = nil
                                configuration.onEditingChanged(false)
                            },
                        TapGesture()
                            .onEnded { _ in
                                self.onSelectUpper()
                            }
                    )
                )

            }
            .frame(height: geometry.size.height)
        }
        .frame(minHeight: max(self.lowerThumbInteractiveSize.height, self.upperThumbInteractiveSize.height))
    }

    public init(track: Track, lowerThumb: LowerThumb, upperThumb: UpperThumb, lowerThumbSize: CGSize = CGSize(width: 27, height: 27), upperThumbSize: CGSize = CGSize(width: 27, height: 27), lowerThumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), upperThumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: RangeSliderOptions = .defaultOptions,
                onSelectLower: @escaping () -> Void = {},
                onSelectUpper: @escaping () -> Void = {}) {
        self.track = track
        self.lowerThumb = lowerThumb
        self.upperThumb = upperThumb
        self.lowerThumbSize = lowerThumbSize
        self.upperThumbSize = upperThumbSize
        self.lowerThumbInteractiveSize = lowerThumbInteractiveSize
        self.upperThumbInteractiveSize = upperThumbInteractiveSize
        self.options = options
      self.onSelectLower = onSelectLower
      self.onSelectUpper = onSelectUpper
    }
}

extension HorizontalRangeSliderStyle where Track == DefaultHorizontalRangeTrack {
    public init(lowerThumb: LowerThumb, upperThumb: UpperThumb, lowerThumbSize: CGSize = CGSize(width: 27, height: 27), upperThumbSize: CGSize = CGSize(width: 27, height: 27), lowerThumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), upperThumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: RangeSliderOptions = .defaultOptions,
    onSelectLower: @escaping () -> Void = {},
    onSelectUpper: @escaping () -> Void = {}) {
        self.track = DefaultHorizontalRangeTrack()
        self.lowerThumb = lowerThumb
        self.upperThumb = upperThumb
        self.lowerThumbSize = lowerThumbSize
        self.upperThumbSize = upperThumbSize
        self.lowerThumbInteractiveSize = lowerThumbInteractiveSize
        self.upperThumbInteractiveSize = upperThumbInteractiveSize
        self.options = options
      self.onSelectLower = onSelectLower
      self.onSelectUpper = onSelectUpper

    }
}

extension HorizontalRangeSliderStyle where LowerThumb == DefaultThumb, UpperThumb == DefaultThumb {
    public init(track: Track, lowerThumbSize: CGSize = CGSize(width: 27, height: 27), upperThumbSize: CGSize = CGSize(width: 27, height: 27), lowerThumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), upperThumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: RangeSliderOptions = .defaultOptions,
    onSelectLower: @escaping () -> Void = {},
    onSelectUpper: @escaping () -> Void = {}) {
        self.track = track
        self.lowerThumb = DefaultThumb()
        self.upperThumb = DefaultThumb()
        self.lowerThumbSize = lowerThumbSize
        self.upperThumbSize = upperThumbSize
        self.lowerThumbInteractiveSize = lowerThumbInteractiveSize
        self.upperThumbInteractiveSize = upperThumbInteractiveSize
        self.options = options
      self.onSelectLower = onSelectLower
      self.onSelectUpper = onSelectUpper

    }
}

extension HorizontalRangeSliderStyle where LowerThumb == DefaultThumb, UpperThumb == DefaultThumb, Track == DefaultHorizontalRangeTrack {
    public init(lowerThumbSize: CGSize = CGSize(width: 27, height: 27), upperThumbSize: CGSize = CGSize(width: 27, height: 27), lowerThumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), upperThumbInteractiveSize: CGSize = CGSize(width: 44, height: 44), options: RangeSliderOptions = .defaultOptions,
    onSelectLower: @escaping () -> Void = {},
    onSelectUpper: @escaping () -> Void = {}) {
        self.track = DefaultHorizontalRangeTrack()
        self.lowerThumb = DefaultThumb()
        self.upperThumb = DefaultThumb()
        self.lowerThumbSize = lowerThumbSize
        self.upperThumbSize = upperThumbSize
        self.lowerThumbInteractiveSize = lowerThumbInteractiveSize
        self.upperThumbInteractiveSize = upperThumbInteractiveSize
        self.options = options
      self.onSelectLower = onSelectLower
      self.onSelectUpper = onSelectUpper
    }
}

public struct DefaultHorizontalRangeTrack: View {
    public var body: some View {
        HorizontalRangeTrack()
            .frame(height: 3)
            .background(Color.secondary.opacity(0.25))
            .cornerRadius(1.5)
    }
}
