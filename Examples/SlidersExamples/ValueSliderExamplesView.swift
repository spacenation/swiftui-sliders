import SwiftUI
import Sliders

struct ValueSliderExamplesView: View {
    @State var nativeValue = 0.5
    @State var value1 = 0.5
    @State var value2 = 0.5
    @State var value3 = 0.5
    @State var value4 = 0.5
    
    var body: some View {
        ScrollView {
            //Slider(value: $nativeValue, in: 0.0...1.0)
            ValueSlider(value: $value1)
            ValueSlider(value: $value2)
                .clippedValue(false)
            ValueSlider(value: $value4)
                .sliderStyle(
                    GradientSliderStyle(colors: [.green, .yellow, .red])
                )
            ValueSlider(value: $value3)
                .thickness(6)
                .clippedValue(false)
                .sliderStyle(
                    GradientSliderStyle()
                )
        }
        .padding()
    }
}

struct ValueSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        ValueSliderExamplesView()
    }
}
