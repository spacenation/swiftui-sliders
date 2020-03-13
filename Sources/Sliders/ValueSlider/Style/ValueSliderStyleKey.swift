import SwiftUI

struct ValueSliderStyleKey: EnvironmentKey {
    static let defaultValue: AnyValueSliderStyle = AnyValueSliderStyle(
        HorizontalValueSliderStyle()
    )
}
