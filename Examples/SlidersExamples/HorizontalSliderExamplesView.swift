import SwiftUI
import Sliders

struct HorizontalSliderExamplesView: View {
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
    @State var range10 = 0.3...0.7
    
    var body: some View {
        ScrollView {
            Group {
                
                HTrack(value: value1)
                
                HSlider(value: $value1, in: 0.0...1.0, step: 0.01)
                
                HSlider(
                    value: $value2,
                    trackView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                )

                HSlider(
                    value: $value3,
                    trackView:
                        HTrack(value: value3, in: 0.0...1.0)
                            .frame(height: 8)
                            .animation(.spring(response: 0.7, dampingFraction: 0.4))
                )
                .thumbSize(CGSize(width: 16, height: 16))
                .trackBorderColor(Color.white.opacity(0.2))
                .trackBorderWidth(1)
                .thickness(6)

                HorizontalValueSlider(
                    value: $value4,
                    trackView: LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .leading, endPoint: .trailing)
                )
                .thumbSize(CGSize(width: 48, height: 16))
                .thickness(6)

                HorizontalValueSlider(
                    value: $value5,
                    trackView: HorizontalValueTrack(
                        value: value5,
                        valueView: LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                    )
                )
                .thumbSize(.zero)
                .thickness(30)
            }
            
            Group {
                
                HRangeTrack(range: range1, in: 0.0...1.0)
                
                HorizontalRangeSlider(range: $range1)
                    .thumbSize(CGSize(width: 40, height: 27))
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
                    trackView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing),
                    thumbView: RoundedRectangle(cornerRadius: 8)
                )
                .thumbSize(CGSize(width: 32, height: 32))

                HorizontalRangeSlider(
                    range: $range4,
                    trackView: LinearGradient(gradient: Gradient(colors: [.green, .yellow, .red]), startPoint: .leading, endPoint: .trailing),
                    thumbView: Capsule()
                )
                .thumbSize(CGSize(width: 16, height: 24))
                .thickness(8)

                HorizontalRangeSlider(
                    range: $range6,
                    trackView: HRangeTrack(
                        range: range6,
                        valueView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                    ),
                    thumbView: HalfCapsule()
                )
                .thumbSize(CGSize(width: 26, height: 26))
                .thickness(28)
                .trackBorderColor(.gray)
                .trackBorderWidth(1)
                
                
                HorizontalRangeSlider(
                    range: $range7,
                    trackView: HorizontalRangeTrack(
                        range: range7,
                        valueView: LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                    ).animation(.spring())
                )
                .thumbSize(CGSize(width: 48, height: 24))
                .thickness(8)

                HorizontalRangeSlider(
                    range: $range8,
                    trackView: HorizontalRangeTrack(
                        range: range8,
                        valueView: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
                        trackShape: RoundedRectangle(cornerRadius: 16)
                    ),
                    thumbView: HalfCapsule()
                )
                .height(72)
                .thickness(64)
                .thumbSize(CGSize(width: 32, height: 64))
                .thumbBorderColor(Color.black.opacity(0.3))
                .thumbBorderWidth(2)

                HorizontalRangeSlider(
                    range: $range9,
                    trackView: HRangeTrack(
                        range: range9,
                        valueView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing),
                        trackShape: Ellipse()
                    )
                )
                .height(64)
                .thickness(48)
                .thumbSize(CGSize(width: 16, height: 56))
                .trackBorderColor(Color.white.opacity(0.3))
                .trackBorderWidth(2)

                HorizontalRangeSlider(
                    range: $range10,
                    trackView:
                        HRangeTrack(
                            range: range10,
                            valueView:
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                                VStack {
                                    Text("Any View").font(.largeTitle).foregroundColor(.white)
                                    Text("Place any view here and it will be masked to a selected value range").font(.title).foregroundColor(Color.white.opacity(0.5))
                                }
                            },
                            trackShape: RoundedRectangle(cornerRadius: 10))
                )
                .height(128)
                .thickness(128)
                .thumbSize(CGSize(width: 8, height: 64))
            }
        }
        .padding()
    }
}


struct HorizontalSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalSliderExamplesView()
    }
}
