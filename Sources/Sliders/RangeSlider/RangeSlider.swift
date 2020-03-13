import SwiftUI

public struct RangeSlider: View {
    @Environment(\.rangeSliderStyle) private var style
    @State private var dragOffset: CGFloat?
    
    private var configuration: RangeSliderStyleConfiguration
    
    public var body: some View {
        self.style.makeBody(configuration:
            self.configuration.with(dragOffset: self.$dragOffset)
        )
    }
}

extension RangeSlider {
    init(_ configuration: RangeSliderStyleConfiguration) {
        self.configuration = configuration
    }
}

extension RangeSlider {
    public init<V>(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0.0...1.0, step: V.Stride = 0.001, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
        
        self.init(
            RangeSliderStyleConfiguration(
                range: Binding(
                    get: { CGFloat(range.wrappedValue.lowerBound)...CGFloat(range.wrappedValue.upperBound) },
                    set: { range.wrappedValue = V($0.lowerBound)...V($0.upperBound) }
                ),
                bounds: CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound),
                step: CGFloat(step),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(0)
            )
        )
    }
}
