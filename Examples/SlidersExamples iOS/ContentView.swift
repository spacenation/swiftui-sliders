import SwiftUI
import Sliders

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ValueSliderExamplesView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.fill")
                        Text("Value")
                    }
                }
                .tag(0)
                .frame(minWidth: 300)
            RangeSliderExamplesView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.split.2x1.fill")
                        Text("Range")
                    }
                }
                .tag(1)
                .frame(minWidth: 300)
            SliderStyleExamplesView()
                .tabItem {
                    VStack {
                        Image(systemName: "square.split.2x2.fill")
                        Text("Styles")
                    }
                }
                .tag(2)
                .frame(minWidth: 300)
            SliderBuilderView()
                .tabItem {
                    VStack {
                        Image(systemName: "rectangle.3.offgrid.fill")
                        Text("Builder")
                    }
                }
                .tag(3)
                .frame(minWidth: 300)
        }
        .accentColor(.blue)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
