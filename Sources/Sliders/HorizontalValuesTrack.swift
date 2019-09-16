import SwiftUI

public struct HorizontalValuesTrack<V, TrackShape: InsettableShape>: View where V : BinaryFloatingPoint {
    @Environment(\.trackStyle)
    var style
    
    @usableFromInline
    var preferences = TrackPreferences()
    
    let valueViewPairs: [ValueViewPair<V>]
    let bounds: ClosedRange<V>
    let trackShape: TrackShape
        
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(self.valueViewPairs) { valueViewPair in
                    valueViewPair.view
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .mask(
                            valueViewPair.view
                                .frame(
                                    width: distanceFromZero(
                                        overallLength: geometry.size.width,
                                        value: CGFloat(valueViewPair.value.wrappedValue),
                                        bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                                        startOffset: self.startOffset,
                                        endOffset: self.endOffset
                                    ),
                                    height: geometry.size.height
                                )
                                .fixedSize()
                                .offset(
                                    x: offsetFromCenterToValueDistanceCenter(
                                        overallLength: geometry.size.width,
                                        value: CGFloat(valueViewPair.value.wrappedValue),
                                        bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                                        startOffset: self.startOffset,
                                        endOffset: self.endOffset
                                    )
                                )
                        )
                }
            }
            .overlay(
                self.trackShape
                    .strokeBorder(self.borderColor, lineWidth: self.borderWidth)
            )
            .background(self.backgroundColor)
                .mask(
                    self.trackShape.frame(width: geometry.size.width, height: geometry.size.height)
            )
            .drawingGroup()
        }

    }
}

extension HorizontalValuesTrack {
    public init(valueViewPairs: [ValueViewPair<V>], in bounds: ClosedRange<V> = 0.0...1.0, trackShape: TrackShape) {
        self.valueViewPairs = valueViewPairs
        self.bounds = bounds
        self.trackShape = trackShape
    }
}

extension HorizontalValuesTrack where TrackShape == Capsule {
    public init(valueViewPairs: [ValueViewPair<V>], in bounds: ClosedRange<V> = 0.0...1.0) {
        self.init(valueViewPairs: valueViewPairs, in: bounds, trackShape: Capsule())
    }
    
    public init(valueColorPairs: [ValueColorPair<V>], in bounds: ClosedRange<V> = 0.0...1.0) {
        let valueViewPairs = valueColorPairs.map({ ValueViewPair(value: $0.value, view: AnyView(Capsule().foregroundColor($0.color))) })
        self.init(valueViewPairs: valueViewPairs, in: bounds, trackShape: Capsule())
    }
    
    public init(values: [Binding<V>], in bounds: ClosedRange<V> = 0.0...1.0) {
        let valueViewPairs = values.map({ ValueViewPair(value: $0, view: AnyView(Capsule())) })
        self.init(valueViewPairs: valueViewPairs, in: bounds, trackShape: Capsule())
    }
}

// MARK: Values

extension HorizontalValuesTrack {
    var backgroundColor: Color {
        preferences.backgroundColor ?? style.backgroundColor
    }
    
    var borderColor: Color {
        preferences.borderColor ?? style.borderColor
    }
    
    var borderWidth: CGFloat {
        preferences.borderWidth ?? style.borderWidth
    }
    
    var startOffset: CGFloat {
        preferences.startOffset ?? style.startOffset
    }
    
    var endOffset: CGFloat {
        preferences.endOffset ?? style.endOffset
    }
}

// MARK: Modifiers

public extension HorizontalValuesTrack {
    @inlinable func valueColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.valueColor = color
        return copy
    }
    
    @inlinable func backgroundColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.backgroundColor = color
        return copy
    }

    @inlinable func borderColor(_ color: Color?) -> Self {
        var copy = self
        copy.preferences.borderColor = color
        return copy
    }

    @inlinable func borderWidth(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.borderWidth = length
        return copy
    }
    
    @inlinable func startOffset(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.startOffset = length
        return copy
    }
    
    @inlinable func endOffset(_ length: CGFloat?) -> Self {
        var copy = self
        copy.preferences.endOffset = length
        return copy
    }
}
