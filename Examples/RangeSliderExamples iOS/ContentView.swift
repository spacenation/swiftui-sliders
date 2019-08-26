import RangeSlider
import SwiftUI

struct ContentView: View {
    @State var value = 0.5
    @State var range = 0.2...0.8
    @State var gradientRange = 0.0...1.0
    
    var body: some View {
        NavigationView {
            List {
                Section(header: HStack {
                    Text("Slider")
                    Spacer()
                    Text("\(value.description)")
                }) {
                    Slider(value: $value, in: 0.0...1.0, step: 0.01)
                }
                
                Section(header: HStack {
                    Text("Simple")
                    Spacer()
                    Text("\(range.description)")
                }) {
                    RangeSlider(range: $range, valueView: DefaultValueView())
                }
                
                Section(header: HStack {
                    Text("Gradient")
                    Spacer()
                    Text("\(gradientRange.description)")
                }) {
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
