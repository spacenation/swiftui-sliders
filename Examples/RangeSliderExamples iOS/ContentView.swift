
import RangeSlider
import SwiftUI

struct ContentView: View {
    @State var range = 0.2...0.8
    @State var gradientRange = 0.0...1.0
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Simple")) {
                    RangeSlider(range: $range, valueView: DefaultValueView())
                }
                
                Section(header: Text("Gradient")) {
                    RangeSlider(range: $gradientRange, valueView:
                        LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink]), startPoint: .leading, endPoint: .trailing)
                    )
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Range Slider")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
