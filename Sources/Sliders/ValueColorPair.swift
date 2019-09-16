import SwiftUI

public struct ValueColorPair<V> {
    public let value: Binding<V>
    public let color: Color
    
    public init(value: Binding<V>, color: Color) {
        self.value = value
        self.color = color
    }
    
    public init(value: V, color: Color) {
        self.value = .constant(value)
        self.color = color
    }
}
