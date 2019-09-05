@testable import Sliders
import XCTest

class SliderMathOffsetFromCenterToValueDistanceCenterTests: XCTestCase {
    
    func testOffsetFromCenterToValueDistanceCenter() {
        /// Zero value should have an offset of minus half width
        let zeroValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.0)
        XCTAssert(zeroValueOffset == -50)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.5)
        XCTAssert(halfValueOffset == -25)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 1.0)
        XCTAssert(fullValueOffset == 0)
    }
    
    func testOffsetFromCenterToValueDistanceCenterWithBounds() {
        /// Min value should have an offset of minus half width
        let minValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.25, bounds: 0.25...1.25)
        XCTAssert(minValueOffset == -50)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.0, bounds: -1.0...1.0)
        XCTAssert(halfValueOffset == -25)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 1.0, bounds: -1.0...1.0)
        XCTAssert(fullValueOffset == 0)
    }
    
    func testOffsetFromCenterToValueDistanceCenterWithBoundsAndLeftShiftedOffsets() {
        /// Min value should have an offset of minus half width
        let minValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.25, bounds: 0.25...1.25, startOffset: 2.5, endOffset: 7.5)
        XCTAssert(minValueOffset == -48.75)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.0, bounds: -1.0...1.0, startOffset: 2.5, endOffset: 7.5)
        XCTAssert(halfValueOffset == -26.25)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 1.0, bounds: 0.0...1.0, startOffset: 2.5, endOffset: 7.5)
        XCTAssert(fullValueOffset == -3.75)
    }
    
    func testOffsetFromCenterToValueDistanceCenterWithBoundsAndRightShiftedOffsets() {
        /// Min value should have an offset of minus half width
        let minValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.25, bounds: 0.25...1.25, startOffset: 7.5, endOffset: 2.5)
        XCTAssert(minValueOffset == -46.25)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.0, bounds: -1.0...1.0, startOffset: 7.5, endOffset: 2.5)
        XCTAssert(halfValueOffset == -23.75)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 1.0, bounds: 0.0...1.0, startOffset: 7.5, endOffset: 2.5)
        XCTAssert(fullValueOffset == -1.25)
    }
    
    func testOffsetFromCenterToValueDistanceCenterWithBoundsAndCenteringOffsets() {
        /// Min value should have an offset of minus half width
        let minValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.25, bounds: 0.25...1.25, startOffset: 7.5, endOffset: 7.5)
        XCTAssert(minValueOffset == -46.25)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 0.0, bounds: -1.0...1.0, startOffset: 7.5, endOffset: 7.5)
        XCTAssert(halfValueOffset == -25)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValueDistanceCenter(overallLength: 100, value: 1.0, bounds: 0.0...1.0, startOffset: 7.5, endOffset: 7.5)
        XCTAssert(fullValueOffset == -3.75)
    }

}
