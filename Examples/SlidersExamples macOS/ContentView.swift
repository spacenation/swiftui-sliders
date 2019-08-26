import SwiftUI
import Sliders

struct ContentView: View {
    @State var value = 0.5
    @State var range = 0.2...0.8
    @State var gradientRange1 = 0.2...0.8
    @State var gradientRange2 = 0.1...0.9
    
    var body: some View {
        VStack {
            Section(header: HStack {
                Text("Slider")
                Spacer()
                Text("\(value.description)")
            }) {
                Slider(value: $value, in: 0.0...1.0)
            }
            
            Section(header: HStack {
                Text("Simple")
                Spacer()
                Text("\(range.description)")
            }) {
                RangeSlider(range: $range)
            }
            
            Section(header: HStack {
                Text("Gradient")
                Spacer()
            }) {
                RangeSlider(range: $gradientRange1)
                    .thickness(6)
                    .clippedValue(false)
                    .sliderStyle(
                        GradientSliderStyle()
                    )
                RangeSlider(range: $gradientRange2)
                    .sliderStyle(
                        GradientSliderStyle(colors: [.blue, .red])
                )
            }
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
