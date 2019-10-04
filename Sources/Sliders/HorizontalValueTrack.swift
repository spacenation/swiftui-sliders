import SwiftUI

public typealias HTrack = HorizontalValueTrack

public struct HorizontalValueTrack<V, ValueView: View, TrackShape: InsettableShape>: View where V : BinaryFloatingPoint {
    @Environment(\.trackStyle)
    var style
    
    @usableFromInline
    var preferences = TrackPreferences()
    
    let value: Binding<V>
    let bounds: ClosedRange<V>
    let valueView: ValueView
    let trackShape: TrackShape
        
    public var body: some View {
        GeometryReader { geometry in
            self.valueView
                .foregroundColor(self.valueColor)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .mask(
                    self.valueView
                        .frame(
                            width: distanceFromZero(
                                overallLength: geometry.size.width,
                                value: CGFloat(self.value.wrappedValue),
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
                                value: CGFloat(self.value.wrappedValue),
                                bounds: CGFloat(self.bounds.lowerBound)...CGFloat(self.bounds.upperBound),
                                startOffset: self.startOffset,
                                endOffset: self.endOffset
                            )
                        )
                )
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

extension HorizontalValueTrack {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView, trackShape: TrackShape) {
        self.value = value
        self.bounds = bounds
        self.valueView = valueView
        self.trackShape = trackShape
    }
}

extension HorizontalValueTrack where TrackShape == Capsule {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, valueView: ValueView) {
        self.init(value: value, in: bounds, valueView: valueView, trackShape: Capsule())
    }
}

extension HorizontalValueTrack where ValueView == Capsule {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, trackShape: TrackShape) {
        self.init(value: value, in: bounds, valueView: Capsule(), trackShape: trackShape)
    }
}

extension HorizontalValueTrack where TrackShape == Capsule, ValueView == Capsule {
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0) {
        self.init(value: value, in: bounds, valueView: Capsule(), trackShape: Capsule())
    }
}

// MARK: Values

extension HorizontalValueTrack {
    var valueColor: Color {
        preferences.valueColor ?? style.valueColor
    }
    
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

public extension HorizontalValueTrack {
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
