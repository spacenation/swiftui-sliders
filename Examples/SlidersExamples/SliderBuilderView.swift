import SwiftUI
import Sliders

struct SliderBuilderView: View {
    @State private var value: Float = 0.5
    @State private var range: ClosedRange<Float> = 0.2...0.8
    @State private var style: CustomSliderStyle = CustomSliderStyle()
    
    var body: some View {
        VStack {
            RangeSlider(range: $range)
                .sliderStyle(style)

            ScrollView {
                Group {
                    HStack {
                        VStack {
                            Text("Height")
                            Text("\(style.height)")
                        }
                        .font(.footnote)
                        .frame(width: 100)
                        ValueSlider(value: $style.height, in: 44...300, step: 1)
                    }

                    HStack {
                        VStack {
                            Text("Thickness")
                            Text("\(style.thickness)")
                        }
                        .font(.footnote)
                        .frame(width: 100)
                        ValueSlider(value: $style.thickness, in: 1...300, step: 1)
                    }
                }

                Group {
                    HStack {
                        VStack {
                            Text("Thumb Width")
                            Text("\(style.thumbSize.width)")
                        }
                        .font(.footnote)
                        .frame(width: 100)
                        ValueSlider(value: $style.thumbSize.width, in: 1...300, step: 1)
                    }

                    HStack {
                        VStack {
                            Text("Thumb Height")
                            Text("\(style.thumbSize.height)")
                        }
                        .font(.footnote)
                        .frame(width: 100)
                        ValueSlider(value: $style.thumbSize.height, in: 1...300, step: 1)
                    }
                }
            }
            .background(Color.gray.opacity(0.3))
        }
    }
}

struct SliderBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderBuilderView()
    }
}
