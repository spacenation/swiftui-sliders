import SwiftUI

public struct PointSlider: View {
    @Environment(\.pointSliderStyle) private var style
    @State private var dragOffset: CGPoint? = nil
    
    private var configuration: PointSliderStyleConfiguration
    
    public var body: some View {
        self.style.makeBody(configuration:
            self.configuration.with(dragOffset: self.$dragOffset)
        )
    }
}

extension PointSlider {
    init(_ configuration: PointSliderStyleConfiguration) {
        self.configuration = configuration
    }
}

extension PointSlider {
    public init<V>(x: Binding<V>, xBounds: ClosedRange<V> = 0.0...1.0, xStep: V.Stride = 0.001, y: Binding<V>, yBounds: ClosedRange<V> = 0.0...1.0, yStep: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        
        self.init(
            PointSliderStyleConfiguration(
                x: Binding(get: { CGFloat(x.wrappedValue) }, set: { x.wrappedValue = V($0) }),
                xBounds: CGFloat(xBounds.lowerBound)...CGFloat(xBounds.upperBound),
                xStep: CGFloat(xStep),
                y: Binding(get: { CGFloat(y.wrappedValue) }, set: { y.wrappedValue = V($0) }),
                yBounds: CGFloat(yBounds.lowerBound)...CGFloat(yBounds.upperBound),
                yStep: CGFloat(yStep),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(.init())
            )
        )
    }
}

extension PointSlider {
    public init<V>(x: Binding<V>, xBounds: ClosedRange<V> = 0...1, xStep: V.Stride = 1, y: Binding<V>, yBounds: ClosedRange<V> = 0...1, yStep: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryInteger, V.Stride : BinaryInteger {
        
        self.init(
            PointSliderStyleConfiguration(
                x: Binding(get: { CGFloat(x.wrappedValue) }, set: { x.wrappedValue = V($0) }),
                xBounds: CGFloat(xBounds.lowerBound)...CGFloat(xBounds.upperBound),
                xStep: CGFloat(xStep),
                y: Binding(get: { CGFloat(y.wrappedValue) }, set: { y.wrappedValue = V($0) }),
                yBounds: CGFloat(yBounds.lowerBound)...CGFloat(yBounds.upperBound),
                yStep: CGFloat(yStep),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(.init())
            )
        )
    }
}
