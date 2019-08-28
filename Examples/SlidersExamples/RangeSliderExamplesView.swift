import SwiftUI
import Sliders

struct RangeSliderExamplesView: View {
    @State var range1 = 0.2...0.8
    @State var range2 = 1250.0...1750.0
    @State var range3 = 0.1...0.9
    @State var range4 = 0.1...0.9
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Range")
                Spacer()
                Text("\(range1.description)")
                    .foregroundColor(.secondary)
            }
            RangeSlider(range: $range1, step: 0.01)
            RangeSlider(range: $range2, in: 1000...2000)
                .clippedValue(false)
            RangeSlider(range: $range3)
                .sliderStyle(
                    GradientSliderStyle(colors: [.blue, .red])
                )
            RangeSlider(range: $range4)
                .clippedValue(false)
                .sliderStyle(
                    GradientSliderStyle()
                )
        }
        .padding()
    }
}

struct RangeSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        RangeSliderExamplesView()
    }
}
