import SwiftUI

public struct AnyPointSliderStyle: PointSliderStyle {
    private let styleMakeBody: (PointSliderStyle.Configuration) -> AnyView
    
    public init<S: PointSliderStyle>(_ style: S) {
        self.styleMakeBody = style.makeTypeErasedBody
    }
    
    public func makeBody(configuration: PointSliderStyle.Configuration) -> AnyView {
        self.styleMakeBody(configuration)
    }
}

fileprivate extension PointSliderStyle {
    func makeTypeErasedBody(configuration: PointSliderStyle.Configuration) -> AnyView {
        AnyView(makeBody(configuration: configuration))
    }
}
