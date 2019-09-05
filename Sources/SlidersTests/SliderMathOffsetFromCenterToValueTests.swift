@testable import Sliders
import XCTest

class SliderMathOffsetFromCenterToValueTests: XCTestCase {
    
    func testOffsetFromCenterToValue() {
        /// Zero value should have an offset of minus half width
        let zeroValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.0)
        XCTAssert(zeroValueOffset == -50)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.5)
        XCTAssert(halfValueOffset == 0)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValue(overallLength: 100, value: 1.0)
        XCTAssert(fullValueOffset == 50)
    }
    
    func testOffsetFromCenterToValueWithBounds() {
        /// Min value should have an offset of minus half width
        let minValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.25, bounds: 0.25...1.25)
        XCTAssert(minValueOffset == -50)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.0, bounds: -1.0...1.0)
        XCTAssert(halfValueOffset == 0)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValue(overallLength: 100, value: 1.0, bounds: -1.0...1.0)
        XCTAssert(fullValueOffset == 50)
    }
    
    func testOffsetFromCenterToValueWithBoundsAndLeftShiftedOffsets() {
        /// Min value should have an offset of minus half width
        let minValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.25, bounds: 0.25...1.25, startOffset: 5, endOffset: 15)
        XCTAssert(minValueOffset == -45)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.0, bounds: -1.0...1.0, startOffset: 5, endOffset: 15)
        XCTAssert(halfValueOffset == -5)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValue(overallLength: 100, value: 1.0, bounds: 0.0...1.0, startOffset: 5, endOffset: 15)
        XCTAssert(fullValueOffset == 35)
    }
    
    func testOffsetFromCenterToValueWithBoundsAndRightShiftedOffsets() {
        /// Min value should have an offset of minus half width
        let minValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.25, bounds: 0.25...1.25, startOffset: 15, endOffset: 5)
        XCTAssert(minValueOffset == -35)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.0, bounds: -1.0...1.0, startOffset: 15, endOffset: 5)
        XCTAssert(halfValueOffset == 5)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValue(overallLength: 100, value: 1.0, bounds: 0.0...1.0, startOffset: 15, endOffset: 5)
        XCTAssert(fullValueOffset == 45)
    }
    
    func testOffsetFromCenterToValueWithBoundsAndCenteringOffsets() {
        /// Min value should have an offset of minus half width
        let minValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.25, bounds: 0.25...1.25, startOffset: 10, endOffset: 10)
        XCTAssert(minValueOffset == -40)
        
        /// Half value should have an offset of overallLength / 4
        let halfValueOffset = offsetFromCenterToValue(overallLength: 100, value: 0.0, bounds: -1.0...1.0, startOffset: 10, endOffset: 10)
        XCTAssert(halfValueOffset == 0)
        
        /// Full value should have an offset of 0
        let fullValueOffset = offsetFromCenterToValue(overallLength: 100, value: 1.0, bounds: 0.0...1.0, startOffset: 10, endOffset: 10)
        XCTAssert(fullValueOffset == 40)
    }
}
