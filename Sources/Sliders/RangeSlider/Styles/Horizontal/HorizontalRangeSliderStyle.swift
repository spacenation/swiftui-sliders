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

    private func lowerX(configuration: Self.Configuration, geometry: GeometryProxy) -> CGFloat {
        distanceFrom(
            value: configuration.range.wrappedValue.lowerBound,
            availableDistance: geometry.size.width,
            bounds: configuration.bounds,
            leadingOffset: lowerThumbSize.width / 2,
            trailingOffset: lowerThumbSize.width / 2 + upperThumbSize.width
        )
    }

    private func upperX(configuration: Self.Configuration, geometry: GeometryProxy) -> CGFloat {
        distanceFrom(
            value: configuration.range.wrappedValue.upperBound,
            availableDistance: geometry.size.width,
            bounds: configuration.bounds,
            leadingOffset: lowerThumbSize.width + upperThumbSize.width / 2,
            trailingOffset: upperThumbSize.width / 2
        )
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        let editing = { () -> EditingRange in
            switch (
                configuration.lowerGestureState.wrappedValue?.speed,
                configuration.upperGestureState.wrappedValue?.speed
            ) {
            case (_?, _?): return [.upper, .lower]
            case (_?, nil): return [.lower]
            case (nil, _?): return [.upper]
            case (nil, nil): return []
            }
        }()
        let precisionScrubbingSpeed = { () -> Float? in
            switch (
                configuration.lowerGestureState.wrappedValue?.speed,
                configuration.upperGestureState.wrappedValue?.speed
            ) {
            case (let lower?, let upper?): return min(lower, upper)
            case (let only?, nil), (nil, let only?): return only
            case (nil, nil): return nil
            }
        }()

        return GeometryReader { geometry in
            let fullBleedTrack = self.options.contains(.fullBleedTrack)
            ZStack {
                self.track
                    .environment(\.trackRange, configuration.range.wrappedValue)
                    .environment(\.rangeTrackConfiguration, RangeTrackConfiguration(
                        bounds: configuration.bounds,
                        lowerLeadingOffset: fullBleedTrack ? 0 : self.lowerThumbSize.width / 2,
                        lowerTrailingOffset: self.upperThumbSize.width + (fullBleedTrack ? 0 : self.lowerThumbSize.width / 2),
                        upperLeadingOffset: self.lowerThumbSize.width + (fullBleedTrack ? 0 : self.upperThumbSize.width / 2),
                        upperTrailingOffset: fullBleedTrack ? 0 : self.upperThumbSize.width / 2
                    ))
                    .accentColor(Color.accentColor)

                ZStack {
                    self.lowerThumb
                        .frame(width: self.lowerThumbSize.width, height: self.lowerThumbSize.height)
                }
                .frame(minWidth: self.lowerThumbInteractiveSize.width, minHeight: self.lowerThumbInteractiveSize.height)
                .position(
                    x: lowerX(configuration: configuration, geometry: geometry),
                    y: geometry.size.height / 2
                )
                .gesture(
                    SimultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .updating(configuration.lowerGestureState) { value, state, transaction in
                                state = (state ?? {
                                    let x = lowerX(configuration: configuration, geometry: geometry)
                                    return SliderGestureState(initialOffset: value.location.x - x)
                                }()).updating(
                                    with: value.location.x,
                                    speed: configuration.precisionScrubbing.scrubValue(Float(value.translation.height))
                                )
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
                    x: upperX(configuration: configuration, geometry: geometry),
                    y: geometry.size.height / 2
                )
                .gesture(
                    SimultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .updating(configuration.upperGestureState) { value, state, transaction in
                                state = (state ?? { () -> SliderGestureState in
                                    let x = upperX(configuration: configuration, geometry: geometry)
                                    return SliderGestureState(initialOffset: value.location.x - x)
                                }()).updating(
                                    with: value.location.x,
                                    speed: configuration.precisionScrubbing.scrubValue(Float(value.translation.height))
                                )
                            },
                        TapGesture()
                            .onEnded { _ in
                                self.onSelectUpper()
                            }
                    )
                )

            }
            .frame(height: geometry.size.height)
            .onChange(of: configuration.lowerGestureState.wrappedValue) { state in
                guard let state else { return }

                let computedLowerBound = valueFrom(
                    distance: state.offset - (configuration.dragOffset.wrappedValue ?? 0),
                    availableDistance: geometry.size.width,
                    bounds: configuration.bounds,
                    step: configuration.step,
                    leadingOffset: lowerThumbSize.width / 2,
                    trailingOffset: lowerThumbSize.width / 2 + upperThumbSize.width
                )

                configuration.range.wrappedValue = rangeFrom(
                    updatedLowerBound: computedLowerBound,
                    upperBound: configuration.range.wrappedValue.upperBound,
                    bounds: configuration.bounds,
                    distance: configuration.distance,
                    forceAdjacent: options.contains(.forceAdjacentValue)
                )
            }
            .onChange(of: configuration.upperGestureState.wrappedValue) { state in
                guard let state else { return }

                let computedUpperBound = valueFrom(
                    distance: state.offset - (configuration.dragOffset.wrappedValue ?? 0),
                    availableDistance: geometry.size.width,
                    bounds: configuration.bounds,
                    step: configuration.step,
                    leadingOffset: lowerThumbSize.width + upperThumbSize.width / 2,
                    trailingOffset: upperThumbSize.width / 2
                )

                configuration.range.wrappedValue = rangeFrom(
                    lowerBound: configuration.range.wrappedValue.lowerBound,
                    updatedUpperBound: computedUpperBound,
                    bounds: configuration.bounds,
                    distance: configuration.distance,
                    forceAdjacent: options.contains(.forceAdjacentValue)
                )
            }
            .onChange(of: editing) { editing in
                configuration.onEditingChanged(editing)
            }
            .onChange(of: precisionScrubbingSpeed) { precisionScrubbingSpeed in
                configuration.precisionScrubbing.onChange?(precisionScrubbingSpeed)
            }
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
