import SwiftUI
import Sliders

struct HorizontalSliderExamplesView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView {
            Group {
                
                Slider(value: $model.value1)

                ValueSlider(value: $model.value1)

                ValueSlider(value: $model.value2)
                    .valueSliderStyle(
                        HorizontalValueSliderStyle(thumbSize: CGSize(width: 16, height: 32))
                    )
                
                ValueSlider(value: $model.value3)
                    .valueSliderStyle(
                        HorizontalValueSliderStyle(
                            track: LinearGradient(
                                gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(height: 8)
                            .cornerRadius(4)
                        )
                    )

                
                ValueSlider(value: $model.value4)
                    .valueSliderStyle(
                        HorizontalValueSliderStyle(
                            track: LinearGradient(
                                gradient: Gradient(colors: [.purple, .blue, .purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(height: 6)
                            .cornerRadius(3),
                            thumbSize: CGSize(width: 48, height: 16)
                        )
                    )
            }

            Group {
                RangeSlider(range: $model.range1)
                
                RangeSlider(range: $model.range2)
                    .rangeSliderStyle(
                        HorizontalRangeSliderStyle(
                            track:
                                HorizontalRangeTrack(
                                    view: Capsule().foregroundColor(.purple)
                                )
                                .background(Capsule().foregroundColor(Color.purple.opacity(0.25)))
                                .frame(height: 8),
                            lowerThumb: Circle().foregroundColor(.purple),
                            upperThumb: Circle().foregroundColor(.purple),
                            lowerThumbSize: CGSize(width: 32, height: 32),
                            upperThumbSize: CGSize(width: 32, height: 32),
                            options: .forceAdjacentValue
                        )
                    )
                
                RangeSlider(range: $model.range3)
                    .rangeSliderStyle(
                        HorizontalRangeSliderStyle(
                            track:
                                HorizontalRangeTrack(
                                    view: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                                )
                                .background(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing).opacity(0.25))
                                .frame(height: 32)
                                .cornerRadius(16),
                            lowerThumb: HalfCapsule().foregroundColor(.white).shadow(radius: 3),
                            upperThumb: HalfCapsule().rotation(Angle(degrees: 180)).foregroundColor(.white).shadow(radius: 3),
                            lowerThumbSize: CGSize(width: 32, height: 32),
                            upperThumbSize: CGSize(width: 32, height: 32)
                        )
                    )
                
                RangeSlider(range: $model.range4)
                    .frame(height: 64)
                    .rangeSliderStyle(
                        HorizontalRangeSliderStyle(
                            track:
                                HorizontalRangeTrack(
                                    view: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .leading, endPoint: .trailing),
                                    mask: Rectangle()
                                )
                                .mask(Ellipse())
                                .background(Ellipse().foregroundColor(Color.secondary.opacity(0.25)))
                                .overlay(Ellipse().strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                                .padding(.vertical, 8),
                            lowerThumbSize: CGSize(width: 16, height: 64),
                            upperThumbSize: CGSize(width: 16, height: 64)
                        )
                    )
                
                RangeSlider(range: $model.range5)
                    .frame(height: 64)
                    .rangeSliderStyle(
                        HorizontalRangeSliderStyle(
                            track:
                                HorizontalRangeTrack(
                                    view: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .leading, endPoint: .trailing),
                                    mask: Rectangle()
                                )
                                .background(Color.secondary.opacity(0.25))
                                .cornerRadius(16),
                            lowerThumb: HalfCapsule().foregroundColor(.white).shadow(radius: 3),
                            upperThumb: HalfCapsule().rotation(Angle(degrees: 180)).foregroundColor(.white).shadow(radius: 3),
                            lowerThumbSize: CGSize(width: 32, height: 64),
                            upperThumbSize: CGSize(width: 32, height: 64)
                        )
                    )
                
                RangeSlider(range: $model.range6)
                    .cornerRadius(8)
                    .frame(height: 128)
                    .rangeSliderStyle(
                        HorizontalRangeSliderStyle(
                            track:
                                HorizontalRangeTrack(
                                    view:
                                        ZStack {
                                              LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                                              VStack {
                                                  Text("Any View")
                                                      .font(.largeTitle)
                                                      .foregroundColor(Color.white)
                                                  Text("Place any view here and it will be masked to a selected value range")
                                                      .font(.title)
                                                      .foregroundColor(Color.white.opacity(0.5))
                                              }
                                        },
                                    mask: RoundedRectangle(cornerRadius: 10)
                                )
                                .background(Color.secondary.opacity(0.25)),
                            lowerThumbSize: CGSize(width: 8, height: 64),
                            upperThumbSize: CGSize(width: 8, height: 64)
                        )
                    )
            }
        }
        .padding()

    }
}


struct HorizontalSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalSliderExamplesView().environmentObject(Model.preview)
    }
}
