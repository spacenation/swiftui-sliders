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
                            Text("Knob Width")
                            Text("\(style.knobSize.width)")
                        }
                        .font(.footnote)
                        .frame(width: 100)
                        ValueSlider(value: $style.knobSize.width, in: 1...300, step: 1)
                    }
                    
                    HStack {
                        VStack {
                            Text("Knob Height")
                            Text("\(style.knobSize.height)")
                        }
                        .font(.footnote)
                        .frame(width: 100)
                        ValueSlider(value: $style.knobSize.height, in: 1...300, step: 1)
                    }
                    
                    HStack {
                        VStack {
                            Text("Knob Corners")
                            Text("\(style.knobCornerRadius)")
                        }
                        .font(.footnote)
                        .frame(width: 100)
                        ValueSlider(value: $style.knobCornerRadius, in: 0...150, step: 1)
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
