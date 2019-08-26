import SwiftUI
import Sliders

struct SliderStyleExamplesView: View {
    @State var value1 = 0.5
    @State var value2 = 0.5
    @State var range1 = 0.1...0.9
    @State var range2 = 0.1...0.9
    
    var body: some View {
        ScrollView {
            ValueSlider(value: $value1)
                .thickness(6)
                .knobSize(CGSize(width: 16, height: 16))
            RangeSlider(range: $range1)
                .knobCornerRadius(2)
            ValueSlider(value: $value2)
                .thickness(8)
                .clippedValue(false)
                .knobSize(CGSize(width: 48, height: 16))
                .sliderStyle(
                    GradientSliderStyle(colors: [.white, .blue])
                )
            RangeSlider(range: $range2)
                .thickness(8)
                .knobCornerRadius(8)
                .knobSize(CGSize(width: 16, height: 24))
                .sliderStyle(
                    GradientSliderStyle()
                )
        }
        .padding()
    }
}

struct SliderStyleExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        SliderStyleExamplesView()
    }
}
