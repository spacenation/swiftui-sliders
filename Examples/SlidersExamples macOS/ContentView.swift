import SwiftUI
import Sliders

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ValueSliderExamplesView()
                .tabItem {
                    Text("Value")
                }
                .tag(0)
                .frame(minWidth: 300)
            RangeSliderExamplesView()
                .tabItem {
                    Text("Range")
                }
                .tag(1)
                .frame(minWidth: 300)
            SliderStyleExamplesView()
                .tabItem {
                    Text("Styles")
                }
                .tag(2)
                .frame(minWidth: 300)
            SliderBuilderView()
                .tabItem {
                    Text("Builder")
                }
                .tag(3)
                .frame(minWidth: 300)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
