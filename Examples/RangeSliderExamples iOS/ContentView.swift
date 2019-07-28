
import RangeSlider
import SwiftUI

struct ContentView: View {
    @State var range1 = 0.0...1.0
    
    var body: some View {
        VStack {
            Text("Hello World")
            RangeSlider(range: $range1)
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
