import SwiftUI

struct AnyPointSliderStyle: PointSliderStyle {
    private let styleMakeBody: (PointSliderStyle.Configuration) -> AnyView
    
    init<S: PointSliderStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    func makeBody(configuration: PointSliderStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension PointSliderStyle {
    func makeTypeErasedBody(configuration: PointSliderStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
