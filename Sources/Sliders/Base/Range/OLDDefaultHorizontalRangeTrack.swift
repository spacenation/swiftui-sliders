import SwiftUI

public struct OLDDefaultHorizontalRangeTrack<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {
    let range: ClosedRange<V>
    let bounds: ClosedRange<V>
    let configuration: RangeTrackConfiguration
    
    public var body: some View {
        HRangeTrack(range: range, in: bounds, configuration: configuration)
            .frame(height: 3)
            .background(Color.secondary.opacity(0.25))
            .cornerRadius(1.5)
    }
    
    public init(range: ClosedRange<V>, in bounds: ClosedRange<V> = 0.0...1.0, configuration: RangeTrackConfiguration = .defaultConfiguration) {
        self.range = range
        self.bounds = bounds
        self.configuration = configuration
    }
}
