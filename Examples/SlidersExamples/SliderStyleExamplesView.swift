import SwiftUI
import Sliders

struct SliderStyleExamplesView: View {
    @State var value1 = 0.5
    @State var value2 = 0.5
    @State var value3 = 0.5
    @State var value4 = 0.5
    @State var value5 = 0.5
    @State var range1 = 0.1...0.9
    @State var range2 = 0.1...0.9
    @State var range3 = 0.1...0.9
    @State var range4 = 0.1...0.9
    @State var range5 = 0.1...0.9
    @State var range6 = 0.1...0.9
    @State var range7 = 0.1...0.9
    @State var range8 = 0.1...0.9
    
    var body: some View {
        ScrollView {
            Group {
                ValueSlider(value: $value1, step: 0.01)
                ValueSlider(value: $value2)
                    .clippedValue(false)
                    .sliderStyle(
                        GradientSliderStyle()
                    )
                ValueSlider(value: $value3)
                    .thickness(6)
                    .knobSize(CGSize(width: 16, height: 16))
                ValueSlider(value: $value4)
                    .thickness(6)
                    .clippedValue(false)
                    .knobSize(CGSize(width: 48, height: 16))
                    .sliderStyle(
                        GradientSliderStyle(colors: [.white, .blue])
                    )
                ValueSlider(value: $value5)
                    .thickness(6)
                    .clippedValue(false)
                    .knobSize(CGSize(width: 16, height: 24))
                    .sliderStyle(
                        GradientSliderStyle(colors: [.black, .blue])
                    )
            }
            
            Group {
                RangeSlider(range: $range1, step: 0.01)
                    .knobBorderWidth(3)
                    .knobBorderColor(.purple)
                    .knobShadowColor(.clear)
                    .clippedValue(false)
                    .valueColor(.purple)
                
                RangeSlider(range: $range2)
                    .knobColor(.blue)
                    .knobShadowColor(.blue)
                    .knobShadowRadius(4)
                    .clippedValue(false)
                RangeSlider(range: $range3)
                    .clippedValue(false)
                    .sliderStyle(
                        GradientSliderStyle()
                    )

                RangeSlider(range: $range4)
                    .thickness(8)
                    .knobCornerRadius(8)
                    .knobSize(CGSize(width: 16, height: 24))
                    .sliderStyle(
                        GradientSliderStyle(colors: [.green, .yellow, .red])
                    )
                RangeSlider(range: $range5)
                    .knobCornerRadius(2)
                RangeSlider(range: $range6)
                    .thickness(28)
                    .knobSize(CGSize(width: 26, height: 26))
                    .trackBorderColor(Color.gray)
                    .trackBorderWidth(1)
                    .sliderStyle(
                        GradientSliderStyle()
                    )
                RangeSlider(range: $range7)
                    .thickness(8)
                    .knobCornerRadius(8)
                    .knobSize(CGSize(width: 48, height: 24))
                    .sliderStyle(
                        GradientSliderStyle(colors: [.blue, .red])
                    )
                
                RangeSlider(range: $range8)
                    .sliderStyle(
                        CustomSliderStyle(
                            height: 72,
                            thickness: 64,
                            knobSize: CGSize(width: 32, height: 64),
                            knobColor: .white,
                            knobCornerRadius: 4,
                            knobBorderColor: .gray,
                            knobBorderWidth: 1,
                            knobShadowColor: .clear,
                            knobShadowRadius: 0,
                            knobShadowX: 0,
                            knobShadowY: 0,
                            trackColor: Color.black.opacity(0.6),
                            trackCornerRadius: 4,
                            trackBorderColor: .clear,
                            trackBorderWidth: 0,
                            clippedValue: true,
                            knobView: AnyView(Rectangle()),
                            valueView: AnyView(LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing)),
                            trackView: AnyView(Rectangle())
                        )
                    )
                    .padding(.horizontal, 32)
            }
        }
        .padding()
    }
}

struct SliderStyleExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        SliderStyleExamplesView()
    }
}
