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
                    get: { CGFloat(range.wrappedValue.clamped(to: bounds).lowerBound)...CGFloat(range.wrappedValue.clamped(to: bounds).upperBound) },
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

extension RangeSlider {
    public init<V>(range: Binding<ClosedRange<V>>, in bounds: ClosedRange<V> = 0...1, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) where V : BinaryInteger, V.Stride : BinaryInteger {
        
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

struct RangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HorizontalRangeSlidersPreview()
            VerticalRangeSlidersPreview()
        }
    }
}

private struct HorizontalRangeSlidersPreview: View {
    @State var range1 = 0.1...0.9
    @State var range2 = 0.1...0.9
    @State var range3 = 0.1...0.9
    @State var range4 = 0.1...0.9
    @State var range5 = 0.1...0.9
    @State var range6 = -2.0...4.0
    
    var body: some View {
        VStack {
            RangeSlider(range: $range1)
            
            RangeSlider(range: $range2)
                .rangeSliderStyle(
                    HorizontalRangeSliderStyle(
                        track:
                            HorizontalRangeTrack(
                                view: Capsule().foregroundColor(.purple)
                            )
                            .background(Capsule().foregroundColor(Color.purple.opacity(0.25)))
                            .frame(height: 8),
                        lowerThumb: Circle().foregroundColor(.purple),
                        upperThumb: Circle().foregroundColor(.purple),
                        lowerThumbSize: CGSize(width: 32, height: 32),
                        upperThumbSize: CGSize(width: 32, height: 32),
                        options: .forceAdjacentValue
                    )
                )
            
            RangeSlider(range: $range3)
                .rangeSliderStyle(
                    HorizontalRangeSliderStyle(
                        track:
                            HorizontalRangeTrack(
                                view: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                            )
                            .background(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing).opacity(0.25))
                            .frame(height: 32)
                            .cornerRadius(16),
                        lowerThumb: HalfCapsule().foregroundColor(.white).shadow(radius: 3),
                        upperThumb: HalfCapsule().rotation(Angle(degrees: 180)).foregroundColor(.white).shadow(radius: 3),
                        lowerThumbSize: CGSize(width: 32, height: 32),
                        upperThumbSize: CGSize(width: 32, height: 32)
                    )
                )
            
            RangeSlider(range: $range4)
                .frame(height: 64)
                .rangeSliderStyle(
                    HorizontalRangeSliderStyle(
                        track:
                            HorizontalRangeTrack(
                                view: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing),
                                mask: Rectangle()
                            )
                            .mask(Ellipse())
                            .background(Ellipse().foregroundColor(Color.secondary.opacity(0.25)))
                            .overlay(Ellipse().strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                            .padding(.vertical, 8),
                        lowerThumbSize: CGSize(width: 16, height: 64),
                        upperThumbSize: CGSize(width: 16, height: 64)
                    )
                )
            
            RangeSlider(range: $range5)
                .frame(height: 64)
                .rangeSliderStyle(
                    HorizontalRangeSliderStyle(
                        track:
                            HorizontalRangeTrack(
                                view: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
                                mask: Rectangle()
                            )
                            .background(Color.secondary.opacity(0.25))
                            .cornerRadius(16),
                        lowerThumb: HalfCapsule().foregroundColor(.white).shadow(radius: 3),
                        upperThumb: HalfCapsule().rotation(Angle(degrees: 180)).foregroundColor(.white).shadow(radius: 3),
                        lowerThumbSize: CGSize(width: 32, height: 64),
                        upperThumbSize: CGSize(width: 32, height: 64)
                    )
                )
            
            RangeSlider(range: $range6, in: 1.0 ... 3.0)
                .cornerRadius(8)
                .frame(height: 128)
                .rangeSliderStyle(
                    HorizontalRangeSliderStyle(
                        track:
                            HorizontalRangeTrack(
                                view: LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing),
                                mask: RoundedRectangle(cornerRadius: 10)
                            )
                            .background(Color.secondary.opacity(0.25)),
                        lowerThumbSize: CGSize(width: 8, height: 64),
                        upperThumbSize: CGSize(width: 8, height: 64)
                    )
                )
        }
        .padding()
    }
}

private struct VerticalRangeSlidersPreview: View {
    @State var range1 = 0.1...0.9
    @State var range2 = 0.1...0.9
    @State var range3 = 0.1...0.9
    @State var range4 = 0.1...0.9
    @State var range5 = 0.1...0.9
    
    var body: some View {
        HStack {
            RangeSlider(range: $range1)
                .rangeSliderStyle(
                    VerticalRangeSliderStyle()
                )
            
            RangeSlider(range: $range2)
                .rangeSliderStyle(
                    VerticalRangeSliderStyle(
                        track:
                            VerticalRangeTrack(
                                view: Capsule().foregroundColor(.purple),
                                mask: Rectangle()
                            )
                            .background(Capsule().foregroundColor(Color.purple.opacity(0.25)))
                            .frame(width: 8),
                        lowerThumb: Circle().foregroundColor(.purple),
                        upperThumb: Circle().foregroundColor(.purple),
                        lowerThumbSize: CGSize(width: 32, height: 32),
                        upperThumbSize: CGSize(width: 48, height: 48)
                    )
                 )
            
            RangeSlider(range: $range3)
                .rangeSliderStyle(
                    VerticalRangeSliderStyle(
                        track:
                            VerticalRangeTrack(
                                view: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top)
                            )
                            .background(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top).opacity(0.25))
                            .frame(width: 8)
                            .cornerRadius(4),
                        lowerThumbSize: CGSize(width: 32, height: 16),
                        upperThumbSize: CGSize(width: 32, height: 16)
                    )
                 )
            
            RangeSlider(range: $range4)
                .frame(width: 64)
                .rangeSliderStyle(
                    VerticalRangeSliderStyle(
                        track:
                            VerticalRangeTrack(
                                view: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .bottom, endPoint: .top),
                                mask: Rectangle()
                            )
                            .mask(Ellipse())
                            .background(Ellipse().foregroundColor(Color.secondary.opacity(0.25)))
                            .overlay(Ellipse().strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                            .padding(.horizontal, 8),
                        lowerThumbSize: CGSize(width: 64, height: 16),
                        upperThumbSize: CGSize(width: 64, height: 16)
                    )
                 )
            
            RangeSlider(range: $range5)
                .frame(width: 64)
                .rangeSliderStyle(
                    VerticalRangeSliderStyle(
                        track:
                            VerticalRangeTrack(
                                view: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .bottom, endPoint: .top),
                                mask: Rectangle()
                            )
                            .background(Color.secondary.opacity(0.25))
                            .cornerRadius(16),
                        lowerThumb: Capsule().foregroundColor(.white).shadow(radius: 3),
                        upperThumb: Capsule().foregroundColor(.white).shadow(radius: 3),
                        lowerThumbSize: CGSize(width: 64, height: 32),
                        upperThumbSize: CGSize(width: 64, height: 32)
                    )
                 )
        }
        .padding()
    }
}

public struct HalfCapsule: View, InsettableShape {
    private let inset: CGFloat

    public func inset(by amount: CGFloat) -> HalfCapsule {
        HalfCapsule(inset: self.inset + amount)
    }
    
    public func path(in rect: CGRect) -> Path {
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let heightRadius = height / 2
        let widthRadius = width / 2
        let minRadius = min(heightRadius, widthRadius)
        return Path { path in
            path.move(to: CGPoint(x: width, y: 0))
            path.addArc(center: CGPoint(x: minRadius, y: minRadius), radius: minRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 180), clockwise: true)
            path.addArc(center: CGPoint(x: minRadius, y: height - minRadius), radius: minRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 90), clockwise: true)
            path.addLine(to: CGPoint(x: width, y: height))
            path.closeSubpath()
        }.offsetBy(dx: inset, dy: inset)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            self.path(in: CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height))
        }
    }
    
    public init(inset: CGFloat = 0) {
        self.inset = inset
    }
}
