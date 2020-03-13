import SwiftUI

/// Defines the implementation of all `RangeSlider` instances within a view
/// hierarchy.
///
/// To configure the current `RangeSlider` for a view hiearchy, use the
/// `.valueSliderStyle()` modifier.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol RangeSliderStyle {
    /// A `View` representing the body of a `RangeSlider`.
    associatedtype Body : View

    /// Creates a `View` representing the body of a `RangeSlider`.
    ///
    /// - Parameter configuration: The properties of the value slider instance being
    ///   created.
    ///
    /// This method will be called for each instance of `RangeSlider` created within
    /// a view hierarchy where this style is the current `RangeSliderStyle`.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a `RangeSlider` instance being created.
    typealias Configuration = RangeSliderStyleConfiguration
}
