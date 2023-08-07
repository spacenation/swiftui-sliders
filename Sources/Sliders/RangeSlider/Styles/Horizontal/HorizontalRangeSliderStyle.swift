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
            trailingOffset: lowerThumbSize.width / 2
        )
    }

    private func upperX(configuration: Self.Configuration, geometry: GeometryProxy) -> CGFloat {
        distanceFrom(
            value: configuration.range.wrappedValue.upperBound,
            availableDistance: geometry.size.width,
            bounds: configuration.bounds,
            leadingOffset: upperThumbSize.width / 2,
            trailingOffset: upperThumbSize.width / 2
        )
    }

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
                    x: lowerX(configuration: configuration, geometry: geometry),
                    y: geometry.size.height / 2
                )
                .gesture(
                    SimultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .updating(configuration.lowerGestureState) { value, state, transaction in
                                state = (state ?? {
                                    let x = lowerX(configuration: configuration, geometry: geometry)
                                    return SliderGestureState(
                                        precisionScrubbing: options.contains(.precisionScrubbing),
                                        initialOffset: value.location.x - x
                                    )
                                }()).updating(
                                    with: value.location.x,
                                    crossAxisOffset: value.translation.height
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
                                    return SliderGestureState(
                                        precisionScrubbing: options.contains(.precisionScrubbing),
                                        initialOffset: value.location.x - x
                                    )
                                }()).updating(
                                    with: value.location.x,
                                    crossAxisOffset: value.translation.height
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
                    trailingOffset: lowerThumbSize.width / 2
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
                    leadingOffset: upperThumbSize.width / 2,
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
            .onChange(of: configuration.lowerGestureState.wrappedValue != nil || configuration.upperGestureState.wrappedValue != nil) { editing in
                configuration.onEditingChanged(editing)
            }
            .onChange(of: configuration.lowerGestureState.wrappedValue?.speed ?? configuration.upperGestureState.wrappedValue?.speed) { speed in
                configuration.onPrecisionScrubbingChange(speed?.rawValue)
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
