import SwiftUI

public struct ValueSlider: View {
    @Environment(\.valueSliderStyle) private var style
    @State private var dragOffset: CGFloat?
    
    private var configuration: ValueSliderStyleConfiguration
    
    public var body: some View {
        self.style.makeBody(configuration:
            self.configuration.with(dragOffset: self.$dragOffset)
        )
    }
}

extension ValueSlider {
    init(_ configuration: ValueSliderStyleConfiguration) {
        self.configuration = configuration
    }
}

extension ValueSlider {
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        
        self.init(
            ValueSliderStyleConfiguration(
                value: Binding(get: { CGFloat(value.wrappedValue) }, set: { value.wrappedValue = V($0) }),
                bounds: CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound),
                step: CGFloat(step),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(0)
            )
        )
    }
}

extension ValueSlider {
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryInteger, V.Stride : BinaryInteger {
        self.init(
            ValueSliderStyleConfiguration(
                value: Binding(get: { CGFloat(value.wrappedValue) }, set: { value.wrappedValue = V($0) }),
                bounds: CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound),
                step: CGFloat(step),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(0)
            )
        )
    }
}

extension ValueSlider {
    public init(value: Binding<Measurement<Unit>>, in bounds: ClosedRange<Measurement<Unit>>, step: Measurement<Unit>, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        
        self.init(
            ValueSliderStyleConfiguration(
                value: Binding(get: {
                    CGFloat(value.wrappedValue.value)
                },
                set: {
                    value.wrappedValue = Measurement<Unit>(value: Double($0), unit: value.wrappedValue.unit)
                }),
                bounds: CGFloat(bounds.lowerBound.value)...CGFloat(bounds.upperBound.value),
                step: CGFloat(step.value),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(0)
            )
        )
    }
}
