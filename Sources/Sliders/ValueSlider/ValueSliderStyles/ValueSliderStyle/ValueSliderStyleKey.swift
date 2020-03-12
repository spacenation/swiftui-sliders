import SwiftUI

struct ValueSliderStyleKey: EnvironmentKey {
    static let defaultValue: AnyValueSliderStyle = AnyValueSliderStyle(
        HorizontalValueSliderStyle(track: ValueTrack(value: 0.5).frame(height: 3))
    )
}
