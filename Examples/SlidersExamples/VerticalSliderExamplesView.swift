import SwiftUI
import Sliders

struct VerticalSliderExamplesView: View {
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
        ScrollView(.horizontal) {
            HStack {
                Group {
                    VerticalValueSlider(value: $value1, step: 0.01)

                    VerticalValueSlider(
                        value: $value2,
                        trackView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top)
                    )

                    VSlider(
                        value: $value3,
                        trackView:
                            VTrack(value: $value3, in: 0.0...1.0)
                                .frame(width: 8)
                                .animation(.spring(response: 0.7, dampingFraction: 0.4))
                    )
                    .thumbSize(CGSize(width: 16, height: 16))
                    .trackBorderColor(Color.white.opacity(0.2))
                    .trackBorderWidth(1)
                    .thickness(6)

                    VerticalValueSlider(
                        value: $value4,
                        trackView: LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .bottom, endPoint: .top)
                    )
                    .thumbSize(CGSize(width: 16, height: 48))
                    .thickness(6)

                    VerticalValueSlider(
                        value: $value5,
                        trackView: LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .bottom, endPoint: .top)
                    )
                    .thumbSize(.zero)
                }

                Group {
                    VerticalRangeSlider(range: $range1, step: 0.01)
                        .sliderStyle(
                            PlainSliderStyle(valueColor: .purple)
                        )

                    VerticalRangeSlider(range: $range2)
                        .thumbBorderWidth(8)
                        .thumbBorderColor(.white)
                        .sliderStyle(
                            PlainSliderStyle(valueColor: .blue)
                        )

                    VerticalRangeSlider(
                        range: $range3,
                        trackView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top),
                        thumbView: RoundedRectangle(cornerRadius: 8)
                    )
                    .thumbSize(CGSize(width: 32, height: 32))

                    VerticalRangeSlider(
                        range: $range4,
                        trackView: LinearGradient(gradient: Gradient(colors: [.green, .yellow, .red]), startPoint: .bottom, endPoint: .top),
                        thumbView: Capsule()
                    )
                    .thumbSize(CGSize(width: 16, height: 24))
                    .thickness(8)

                    VerticalRangeSlider(
                        range: $range5,
                        thumbView: RoundedRectangle(cornerRadius: 4)
                    )

                    VerticalRangeSlider(
                        range: $range6,
                        trackView: VRangeTrack(
                            range: $range6,
                            valueView: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top)
                        ),
                        thumbView: Capsule()
                    )
                    .thumbSize(CGSize(width: 26, height: 26))
                    .thickness(28)
                    .trackBorderColor(.gray)
                    .trackBorderWidth(1)

                    VerticalRangeSlider(
                        range: $range7,
                        trackView: LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .bottom, endPoint: .top)
                    )
                    .thumbSize(CGSize(width: 48, height: 24))
                    .thickness(8)
                    .width(56)

                    VerticalRangeSlider(
                        range: $range8,
                        trackView: VerticalRangeTrack(
                            range: $range8,
                            valueView: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .bottom, endPoint: .top),
                            trackShape: RoundedRectangle(cornerRadius: 16)
                        )
                    )
                    .width(72)
                    .thickness(64)
                    .thumbSize(CGSize(width: 64, height: 32))
                    .thumbBorderColor(Color.black.opacity(0.3))
                    .thumbBorderWidth(2)

                    VerticalRangeSlider(
                        range: $range9,
                        trackView: VerticalRangeTrack(
                            range: $range9,
                            valueView: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .bottom, endPoint: .top), trackShape: Ellipse()
                        )
                    )
                    .width(72)
                    .thickness(48)
                    .thumbSize(CGSize(width: 56, height: 16))
                    .trackBorderColor(Color.white.opacity(0.3))
                    .trackBorderWidth(2)
                }
            }

        }
        .padding()
    }
}

struct VerticalSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalSliderExamplesView()
    }
}
