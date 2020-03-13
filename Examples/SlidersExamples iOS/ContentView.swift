import SwiftUI
import Sliders

struct ContentView: View {
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            HorizontalSliderExamplesView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.split.1x2.fill")
                        Text("Horizontal")
                    }
                }
                .tag(0)
                .frame(minWidth: 300)
            VerticalSliderExamplesView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.split.2x1.fill")
                        Text("Vertical")
                    }
                }
                .tag(1)
                .frame(minWidth: 300)
            
            PointSliderExamplesView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.split.2x2.fill")
                        Text("Point")
                    }
                }
                .tag(2)
                .frame(minWidth: 300)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
