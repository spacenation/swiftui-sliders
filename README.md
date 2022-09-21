## Custom SwiftUI sliders and tracks.
This package allows you to build highly customizable sliders and tracks for iOS, macOS and Mac Catalyst. 

### Features
- Build your own sliders and tracks using composition
- Highly customizable
- Horizontal and Vertical styles
- Range and XY values
- Different sizes for lower and upper range thumbs

<center>
<img src="Resources/sliders.png"/>
</center>

### Styles
- HorizontalValueSliderStyle
- VerticalValueSliderStyle
- HorizontalRangeSliderStyle
- VerticalRangeSliderStyle
- RectangularPointSliderStyle

## How to use

Add this swift package to your project
```
git@github.com:spacenation/swiftui-sliders.git
```

Import and use

```swift
import Sliders
import SwiftUI

struct ContentView: View {
    @State var value = 0.5
    @State var range = 0.2...0.8
    @State var x = 0.5
    @State var y = 0.5
    
    var body: some View {
        Group {
            ValueSlider(value: $value)
            RangeSlider(range: $range)
            PointSlider(x: $x, y: $y)
        }
    }
}
```
See the preview of each file to see an example

## Customization with style
Use any SwiftUI view modifiers to create custom tracks and thumbs.

```swift
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
```

## SDKs
- iOS 13+
- Mac Catalyst 13.0+
- macOS 10.15+
- Xcode 11.0+

## Roadmap
- Circular sliders and tracks

## Code Contributions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.

## Coffee Contributions
If you find this project useful please consider becoming my GitHub sponsor.
