import SwiftUI

struct AnyRangeSliderStyle: RangeSliderStyle {
    private let styleMakeBody: (RangeSliderStyle.Configuration) -> AnyView
    
    init<S: RangeSliderStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    func makeBody(configuration: RangeSliderStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension RangeSliderStyle {
    func makeTypeErasedBody(configuration: RangeSliderStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
