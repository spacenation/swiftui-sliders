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

struct ValueSlider_Previews: PreviewProvider {
    static var previews: some View {
        ValueSlider(value: .constant(0.3))
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
