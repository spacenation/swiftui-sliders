import SwiftUI
import Sliders

struct RangeSliderExamplesView: View {
    @State var range1 = 0.2...0.8
    @State var range2 = 1250.0...1750.0
    @State var range3 = 0.1...0.9
    @State var range4 = 0.1...0.9
    @State var range5 = 0.1...0.9

    var body: some View {
        ScrollView {
            HorizontalRangeSlider(range: $range1, step: 0.01)
            
            HorizontalRangeSlider(range: $range2, in: 1000...2000)
                .clippedValue(false)
            
            HorizontalRangeSlider(range: $range3, valueView:
                    LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                )
            
            HorizontalRangeSlider(range: $range4, valueView:
                    LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                )
                .clippedValue(false)
            
            HorizontalRangeSlider(
                range: $range5,
                trackView: Rectangle(),
                valueView:
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                        VStack {
                            Text("Any View").font(.largeTitle).foregroundColor(.white)
                            Text("Place any view here and it will be masked to a selected value range").font(.title).foregroundColor(Color.white.opacity(0.5))
                        }
                    }
            )
            .height(128)
            .thickness(128)
            .thumbSize(CGSize(width: 8, height: 64))
        }
        .padding()
    }
}

struct RangeSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        RangeSliderExamplesView()
    }
}
