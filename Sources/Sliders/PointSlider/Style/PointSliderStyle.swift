import SwiftUI

/// Defines the implementation of all `PointSlider` instances within a view
/// hierarchy.
///
/// To configure the current `PointSlider` for a view hiearchy, use the
/// `.valueSliderStyle()` modifier.
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol PointSliderStyle {
    /// A `View` representing the body of a `PointSlider`.
    associatedtype Body : View

    /// Creates a `View` representing the body of a `PointSlider`.
    ///
    /// - Parameter configuration: The properties of the value slider instance being
    ///   created.
    ///
    /// This method will be called for each instance of `PointSlider` created within
    /// a view hierarchy where this style is the current `PointSliderStyle`.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a `PointSlider` instance being created.
    typealias Configuration = PointSliderStyleConfiguration
}
