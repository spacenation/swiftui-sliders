import SwiftUI

protocol SliderBase {
    var style: SliderStyle { get }
    var preferences: SliderPreferences { get }
        
    func valueWidth(overallWidth: CGFloat) -> CGFloat
    func valueOffset(overallWidth: CGFloat) -> CGFloat
}

extension SliderBase {
    func generatedValueTrackView<ValueView: View, TrackView: InsettableShape>(geometry: GeometryProxy, valueView: ValueView, trackView: TrackView) -> some View {
        valueView
            .foregroundColor(self.valueColor)
            .frame(width: geometry.size.width, height: self.thickness)
            .mask(
                Rectangle()
                    .frame(
                        width: self.clippedValue ? (self.valueWidth(overallWidth: geometry.size.width) + self.thumbSize.width) : geometry.size.width,
                        height: self.thickness
                    )
                    .fixedSize()
                    .offset(x: self.clippedValue ? self.valueOffset(overallWidth: geometry.size.width) : 0)
            )
            .overlay(
                trackView
                    .strokeBorder(self.trackBorderColor, lineWidth: self.trackBorderWidth)
            )
            .background(self.trackColor)
                .mask(
                    trackView.frame(width: geometry.size.width, height: self.thickness)
            )
    }
    
    func generatedThumbView<ThumbView: InsettableShape>(view: ThumbView) -> some View {
        view
            .overlay(
                view.strokeBorder(self.thumbBorderColor, lineWidth: self.thumbBorderWidth)
            )
            .frame(width: self.thumbSize.width, height:self.thumbSize.height)
            .foregroundColor(self.thumbColor)
            .shadow(color:self.thumbShadowColor, radius: self.thumbShadowRadius, x: self.thumbShadowX, y: self.thumbShadowY)
    }
}

extension SliderBase {
    @inlinable func valueFrom(relativeValue: CGFloat, bounds: ClosedRange<CGFloat>, step: CGFloat) -> CGFloat {
        let newValue = bounds.lowerBound + (relativeValue * (bounds.upperBound - bounds.lowerBound))
        let steppedNewValue = round(newValue / step) * step
        let validatedValue = min(bounds.upperBound, max(bounds.lowerBound, steppedNewValue))
        return validatedValue
    }
}
