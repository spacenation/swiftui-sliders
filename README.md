## SwiftUI Sliders

SwiftUI Sliders with custom styles for iOS, macOS and Mac Catalyst

<center>
<img src="Resources/sliders.png"/>
</center>

## How to use

Add this swift package to  your project
```
git@github.com:spacenation/sliders.git
```

Import and use

```swift
import Sliders
import SwiftUI

struct ContentView: View {
    @State var value = 0.5
    @State var range = 0.2...0.8
    
    var body: some View {
        Group {
            ValueSlider(value: $value)
            RangeSlider(range: $range)
        }
    }
}
```
For more examples open `/Examples/SlidersExamples.xcodeproj`


## Styles
### GradientSliderStyle
```swift
ValueSlider(value: $value)
    .clippedValue(false)
    .sliderStyle(
        GradientSliderStyle()
    )
```
```swift
RangeSlider(range: $range)
    .thickness(6)
    .sliderStyle(
        GradientSliderStyle(colors: [.green, .yellow, .red])
    )
```

### Create your own style with SliderStyle protocol
```swift
public protocol SliderStyle {
    var height: CGFloat { get set }
    var thickness: CGFloat { get set }
    var knobSize: CGSize { get set }
    var knobCornerRadius: CGFloat { get set }
    
    var knobView: AnyView { get }
    var valueView: AnyView { get }
    var trackView: AnyView { get }
    
    var clippedValue: Bool { get set }
}
```

## Custom Modifiers
```swift
RangeSlider(range: $range)
    .height(60)
    .thickness(8)
    .knobCornerRadius(8)
    .knobSize(CGSize(width: 16, height: 24))
    .trackCornerRadius(2)
    .clippedValue(false)
    .sliderStyle(
        GradientSliderStyle()
    )
```

## SDKs
- iOS 13+
- Mac Catalyst 13.0+
- macOS 10.15+
- Xcode 11.0+

## Version 1.0.0
Stable version will be released as soon as XCode 11 GM becomes available. We will strictly follow semantic versioning moving forward.

## Contibutions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.
