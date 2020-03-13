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
                    VRangeSlider(range: $model.range1)
                    
                    VRangeSlider(
                        range: $model.range2,
                        track:
                            OLDVerticalRangeTrack(
                                range: model.range2,
                                view: Capsule().foregroundColor(.purple),
                                mask: Rectangle(),
                                configuration: .init(
                                    lowerOffset: 32,
                                    upperOffset: 48
                                )
                            )
                            .background(Capsule().foregroundColor(Color.purple.opacity(0.25)))
                            .frame(width: 8),
                        lowerThumb: Circle().foregroundColor(.purple),
                        upperThumb: Circle().foregroundColor(.purple),
                        configuration: .init(
                            lowerThumbSize: CGSize(width: 32, height: 32),
                            upperThumbSize: CGSize(width: 48, height: 48)
                        )
                    )
                    
                    VRangeSlider(
                        range: $model.range3,
                        track: OLDVerticalRangeTrack(
                            range: model.range3,
                            value: LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top),
                            configuration: .init(
                                offsets: 16
                            )
                        )
                        .background(LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .bottom, endPoint: .top).opacity(0.25))
                        .frame(width: 8)
                        .cornerRadius(4),
                        configuration: .init(
                            thumbSize: CGSize(width: 32, height: 16)
                        )
                    )
                    
                    VRangeSlider(
                        range: $model.range4,
                        track:
                            OLDVerticalRangeTrack(
                                range: model.range4,
                                view: LinearGradient(gradient: Gradient(colors: [.purple, .blue, .purple]), startPoint: .bottom, endPoint: .top),
                                mask: Rectangle(),
                                configuration: .init(
                                    offsets: 16
                                )
                            )
                            .mask(Ellipse())
                            .background(Ellipse().foregroundColor(Color.secondary.opacity(0.25)))
                            .overlay(Ellipse().strokeBorder(Color.white.opacity(0.5), lineWidth: 1))
                            .padding(.horizontal, 8),
                        configuration: .init(
                            thumbSize: CGSize(width: 64, height: 16)
                        )
                    )
                    .frame(width: 64)
                    
                    VRangeSlider(
                        range: $model.range5,
                        track:
                            OLDVerticalRangeTrack(
                                range: model.range5,
                                view: LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .bottom, endPoint: .top),
                                mask: Rectangle(),
                                configuration: .init(
                                    offsets: 32
                                )
                            )
                            .background(Color.secondary.opacity(0.25))
                            .cornerRadius(16),
                        lowerThumb: Capsule().foregroundColor(.white).shadow(radius: 3),
                        upperThumb: Capsule().foregroundColor(.white).shadow(radius: 3),
                        configuration: .init(
                            thumbSize: CGSize(width: 64, height: 32)
                        )
                    )
                    .frame(width: 64)
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
