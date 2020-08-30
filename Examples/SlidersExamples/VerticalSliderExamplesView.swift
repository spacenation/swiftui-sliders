import SwiftUI
import Sliders

struct VerticalSliderExamplesView: View {
    @EnvironmentObject var model: Model

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Group {
                    ValueSlider(value: $model.value1)
                        .valueSliderStyle(
                            VerticalValueSliderStyle()
                        )
                    
                    ValueSlider(value: $model.value2)
                        .valueSliderStyle(
                            VerticalValueSliderStyle(thumbSize: CGSize(width: 16, height: 32))
                        )
                    
                    ValueSlider(value: $model.value3)
                        .valueSliderStyle(
                            VerticalValueSliderStyle(track:
                                LinearGradient(
                                    gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]),
                                    startPoint: .bottom, endPoint: .top
                                )
                                .frame(width: 8)
                                .cornerRadius(4)
                            )
                        )
                    
                    ValueSlider(value: $model.value4)
                        .valueSliderStyle(
                            VerticalValueSliderStyle(
                                track: LinearGradient(
                                    gradient: Gradient(colors: [.purple, .blue, .purple]),
                                    startPoint: .bottom, endPoint: .top
                                )
                                .frame(width: 6)
                                .cornerRadius(3),
                                thumbSize: CGSize(width: 16, height: 48)
                            )
                        )
                }
                
                Group {
                    RangeSlider(range: $model.range1)
                        .rangeSliderStyle(
                            VerticalRangeSliderStyle()
                        )
                    
                    RangeSlider(range: $model.range2)
                        .rangeSliderStyle(
                            VerticalRangeSliderStyle(
                                track:
                                    VerticalRangeTrack(
                                        view: Capsule().foregroundColor(.purple),
                                        mask: Rectangle()
                                    )
                                    .background(Capsule().foregroundColor(Color.purple.opacity(0.25)))
                                    .frame(width: 8),
                                lowerThumb: Circle().foregroundColor(.purple),
                                upperThumb: Circle().foregroundColor(.purple),
                                lowerThumbSize: CGSize(width: 32, height: 32),
                                upperThumbSize: CGSize(width: 48, height: 48)
                            )
                         )
                    
                    RangeSlider(range: $model.range3)
                        .rangeSliderStyle(
                            VerticalRangeSliderStyle(
                                track:
                                    VerticalRangeTrack(
                                        view: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top)
                                    )
                                    .background(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top).opacity(0.25))
                                    .frame(width: 8)
                                    .cornerRadius(4),
                                lowerThumbSize: CGSize(width: 32, height: 16),
                                upperThumbSize: CGSize(width: 32, height: 16)
                            )
                         )
                    
                    RangeSlider(range: $model.range4)
                        .frame(width: 64)
                        .rangeSliderStyle(
                            VerticalRangeSliderStyle(
                                track:
                                    VerticalRangeTrack(
                                        view: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .bottom, endPoint: .top),
                                        mask: Rectangle()
                                    )
                                    .mask(Ellipse())
                                    .background(Ellipse().foregroundColor(Color.secondary.opacity(0.25)))
                                    .overlay(Ellipse().strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                                    .padding(.horizontal, 8),
                                lowerThumbSize: CGSize(width: 64, height: 16),
                                upperThumbSize: CGSize(width: 64, height: 16)
                            )
                         )
                    
                    RangeSlider(range: $model.range5)
                        .frame(width: 64)
                        .rangeSliderStyle(
                            VerticalRangeSliderStyle(
                                track:
                                    VerticalRangeTrack(
                                        view: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .bottom, endPoint: .top),
                                        mask: Rectangle()
                                    )
                                    .background(Color.secondary.opacity(0.25))
                                    .cornerRadius(16),
                                lowerThumb: Capsule().foregroundColor(.white).shadow(radius: 3),
                                upperThumb: Capsule().foregroundColor(.white).shadow(radius: 3),
                                lowerThumbSize: CGSize(width: 64, height: 32),
                                upperThumbSize: CGSize(width: 64, height: 32)
                            )
                         )
                }
            }

        }
        .padding()
    }
}

struct VerticalSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        VerticalSliderExamplesView().environmentObject(Model.preview)
    }
}
