import SwiftUI
import Sliders

struct PointSliderExamplesView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                PointSlider(x: $model.pointX1, y: $model.pointY1)
                    .frame(height: 256)
                    .pointSliderStyle(
                        RectangularPointSliderStyle(
                            track:
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                                    LinearGradient(gradient: Gradient(colors: [.white, .clear]), startPoint: .bottom, endPoint: .top).blendMode(.hardLight)
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .strokeBorder(lineWidth: 4)
                                        .foregroundColor(Color.white)
                                )
                                .cornerRadius(24),
                            thumbSize: CGSize(width: 48, height: 48)
                        )
                    )
                
                PointSlider(x: $model.pointX2,y: $model.pointY2)
                    .frame(height: 256)
                    .pointSliderStyle(
                        RectangularPointSliderStyle(
                            track:
                                ZStack {
                                      LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .leading, endPoint: .trailing)
                                      VStack {
                                          Text("Any View")
                                              .font(.largeTitle)
                                              .foregroundColor(Color.white)
                                          Text("Place any view here")
                                              .font(.title)
                                              .foregroundColor(Color.white.opacity(0.5))
                                      }
                                }
                                .cornerRadius(24),
                            thumb:
                                Capsule()
                                    .foregroundColor(.white)
                                    .shadow(radius: 3),
                            thumbSize: CGSize(width: 96, height: 48),
                            options: .interactiveTrack
                        )
                    )
            }

        }
        .padding()
    }
}


struct PointSliderExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        PointSliderExamplesView().environmentObject(Model.preview)
    }
}
