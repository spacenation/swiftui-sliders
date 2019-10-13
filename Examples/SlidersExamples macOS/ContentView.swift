import SwiftUI
import Sliders

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HorizontalSliderExamplesView()
                .tabItem {
                    Text("Horizontal")
                }
                .tag(0)
                .frame(minWidth: 300)
            
            VerticalSliderExamplesView()
                .tabItem {
                    Text("Vertical")
                }
                .tag(1)
                .frame(minWidth: 300)
    
            PointSliderExamplesView()
                .tabItem {
                    Text("Point")
                }
                .tag(2)
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
