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
                value: Binding(get: { CGFloat(value.wrappedValue.clamped(to: bounds)) }, set: { value.wrappedValue = V($0) }),
                bounds: CGFloat(bounds.lowerBound)...CGFloat(bounds.upperBound),
                step: CGFloat(step),
                onEditingChanged: onEditingChanged,
                dragOffset: .constant(0)
            )
        )
    }
}

extension ValueSlider {
    public init<V>(value: Binding<V>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : FixedWidthInteger, V.Stride : FixedWidthInteger {
        self.init(
            ValueSliderStyleConfiguration(
                value: Binding(get: { CGFloat(value.wrappedValue.clamped(to: bounds)) }, set: { value.wrappedValue = V($0) }),
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


struct ValueSlider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalValueSlidersPreview()
            VerticalValueSlidersPreview()
        }
    }
}

private struct HorizontalValueSlidersPreview: View {
    @State var value1 = 0.5
    @State var value2 = 0.5
    @State var value3 = 0.5
    @State var value4 = 0.5
    @State var value5 = 0.5
    
    var body: some View {
        VStack {
            Slider(value: $value1)

            ValueSlider(value: $value1)

            ValueSlider(value: $value2)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(thumbSize: CGSize(width: 16, height: 32))
                )
            
            ValueSlider(value: $value3)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(
                        track: LinearGradient(
                            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(height: 8)
                        .cornerRadius(4)
                    )
                )

            
            ValueSlider(value: $value4)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(
                        track: LinearGradient(
                            gradient: Gradient(colors: [.purple, .blue, .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(height: 6)
                        .cornerRadius(3),
                        thumbSize: CGSize(width: 48, height: 16),
                        options: .interactiveTrack
                    )
                )
            
            ValueSlider(value: $value5)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(
                        track:
                            HorizontalTrack(view: Color.blue)
                                .frame(height: 3)
                                .background(Color.red)
                                .cornerRadius(1.5)
                    )
                )
        }
        .padding()
    }
}

private struct VerticalValueSlidersPreview: View {
    @State var value1 = 0.5
    @State var value2 = 0.5
    @State var value3 = 0.5
    @State var value4 = 4.0
    @State var value5 = 0.5
    
    var body: some View {
        HStack {
            ValueSlider(value: $value1)
                .valueSliderStyle(
                    VerticalValueSliderStyle()
                )
            
            ValueSlider(value: $value2)
                .valueSliderStyle(
                    VerticalValueSliderStyle(thumbSize: CGSize(width: 16, height: 32))
                )
            
            ValueSlider(value: $value3)
                .valueSliderStyle(
                    VerticalValueSliderStyle(track:
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]),
                            startPoint: .bottom, endPoint: .top
                        )
                        .frame(width: 8)
                        .cornerRadius(4)
                    )
                )
            
            ValueSlider(value: $value4, in: 1.0 ... 3.0)
                .valueSliderStyle(
                    VerticalValueSliderStyle(
                        track: LinearGradient(
                            gradient: Gradient(colors: [.purple, .blue, .purple]),
                            startPoint: .bottom, endPoint: .top
                        )
                        .frame(width: 6)
                        .cornerRadius(3),
                        thumbSize: CGSize(width: 16, height: 48),
                        options: .interactiveTrack
                    )
                )
            
            ValueSlider(value: $value5)
                .valueSliderStyle(
                    VerticalValueSliderStyle(
                        track:
                            VerticalTrack(view: Color.blue)
                                .frame(width: 3)
                                .background(Color.red)
                                .cornerRadius(1.5)
                    )
                )
        }
        .padding()
    }
}
