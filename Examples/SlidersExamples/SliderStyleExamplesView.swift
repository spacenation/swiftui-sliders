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
    @State var range9 = 0.1...0.9
    
    var body: some View {
        ScrollView {
            Group {
                HorizontalValueSlider(value: $value1, step: 0.01)
                
                HorizontalValueSlider(
                    value: $value2,
                    valueView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                )
                .clippedValue(false)
                
                HorizontalValueSlider(value: $value3)
                    .thumbSize(CGSize(width: 16, height: 16))
                    .thickness(6)
                
                HorizontalValueSlider(
                    value: $value4,
                    valueView: LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .leading, endPoint: .trailing)
                )
                .thumbSize(CGSize(width: 48, height: 16))
                .thickness(6)
                .clippedValue(false)
                
                HorizontalValueSlider(
                    value: $value5,
                    valueView: LinearGradient(gradient: Gradient(colors: [.gray, .blue]), startPoint: .leading, endPoint: .trailing)
                )
                .thumbSize(CGSize(width: 16, height: 24))
                .thickness(6)
                .clippedValue(false)
            }
            
            Group {
                HorizontalRangeSlider(range: $range1, step: 0.01)
                    .sliderStyle(
                        PlainSliderStyle(valueColor: .purple)
                    )
                
                HorizontalRangeSlider(range: $range2)
                    .thumbBorderWidth(8)
                    .thumbBorderColor(.white)
                    .sliderStyle(
                        PlainSliderStyle(valueColor: .blue)
                    )
                
                HorizontalRangeSlider(
                    range: $range3,
                    valueView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing),
                    thumbView: RoundedRectangle(cornerRadius: 8).rotation(Angle(degrees: 45))
                )
                .thumbSize(CGSize(width: 32, height: 32))
                .clippedValue(false)

                HorizontalRangeSlider(
                    range: $range4,
                    valueView: LinearGradient(gradient: Gradient(colors: [.green, .yellow, .red]), startPoint: .leading, endPoint: .trailing),
                    thumbView: Capsule()
                )
                .thumbSize(CGSize(width: 16, height: 24))
                .thickness(8)
                
                HorizontalRangeSlider(
                    range: $range5,
                    trackView: Rectangle(),
                    thumbView: RoundedRectangle(cornerRadius: 4)
                )
                
                HorizontalRangeSlider(
                    range: $range6,
                    valueView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing),
                    thumbView: HalfCapsule()
                )
                .thumbSize(CGSize(width: 26, height: 26))
                .thickness(28)
                .trackBorderColor(.gray)
                .trackBorderWidth(1)
                
                HorizontalRangeSlider(
                    range: $range7,
                    valueView: LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                )
                .thumbSize(CGSize(width: 48, height: 24))
                .thickness(8)
                    
                
                HorizontalRangeSlider(
                    range: $range8,
                    trackView: RoundedRectangle(cornerRadius: 16),
                    valueView: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
                    thumbView: HalfCapsule()
                )
                .height(72)
                .thickness(64)
                .thumbSize(CGSize(width: 32, height: 64))
                .thumbBorderColor(Color.black.opacity(0.3))
                .thumbBorderWidth(2)
                
                HorizontalRangeSlider(
                    range: $range9,
                    trackView: Ellipse(),
                    valueView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing)
                )
                .height(64)
                .thickness(48)
                .thumbSize(CGSize(width: 16, height: 56))
                .trackBorderColor(Color.white.opacity(0.3))
                .trackBorderWidth(2)
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
