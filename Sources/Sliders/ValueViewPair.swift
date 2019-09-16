import SwiftUI

public struct ValueViewPair<V>: Identifiable {
    public let id = UUID()
    public let value: Binding<V>
    public let view: AnyView
    
    public init(value: Binding<V>, view: AnyView) {
        self.value = value
        self.view = view
    }
}
