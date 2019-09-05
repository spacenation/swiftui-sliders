@testable import Sliders
import XCTest

class SliderMathOffsetFromCenterToRangeCenterTests: XCTestCase {
    
    func testOffsetFromCenterToRangeCenter() {
        let zeroValueOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 0.5...0.5)
        XCTAssert(zeroValueOffset == 0)
        
        let halfCenteredRangeOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 0.25...0.75)
        XCTAssert(halfCenteredRangeOffset == 0)
        
        let halfNotCenteredRangeOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 0.0...0.5)
        XCTAssert(halfNotCenteredRangeOffset == -25)
        
        let fullValueOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 0.0...1.0)
        XCTAssert(fullValueOffset == 0)
    }
    
    func testOffsetFromCenterToRangeCenterWithBounds() {
        let zeroValueOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 0.5...0.5, bounds: 0.25...0.75)
        XCTAssert(zeroValueOffset == 0)
        
        let halfCenteredRangeOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 1.5...2.5, bounds: 1.0...3.0)
        XCTAssert(halfCenteredRangeOffset == 0)
        
        let halfNotCenteredRangeOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 0.5...1.5, bounds: 1.0...3.0)
        XCTAssert(halfNotCenteredRangeOffset == -50)
        
        let fullValueOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: -1.0...1.0, bounds: -1.0...1.0)
        XCTAssert(fullValueOffset == 0)
    }
    
    func testOffsetFromCenterToRangeCenterWithBoundsAndOffsets() {
        let zeroValueOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 0.5...0.5, bounds: 0.25...0.75, lowerStartOffset: 5, lowerEndOffset: 15, upperStartOffset: 10, upperEndOffset: 5)
        XCTAssert(zeroValueOffset == -1.25)
        
        let halfCenteredRangeOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 1.5...2.5, bounds: 1.0...3.0, lowerStartOffset: 20, lowerEndOffset: 20, upperStartOffset: 20, upperEndOffset: 20)
        XCTAssert(halfCenteredRangeOffset == 0)
        
        let halfNotCenteredRangeOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: 0.5...1.5, bounds: 1.0...3.0, lowerStartOffset: 10, lowerEndOffset: 20, upperStartOffset: 5, upperEndOffset: 30)
        XCTAssert(halfNotCenteredRangeOffset == -43.125)
        
        let fullValueOffset = offsetFromCenterToRangeCenter(overallLength: 100, range: -1.0...1.0, bounds: -1.0...1.0, lowerStartOffset: 0, lowerEndOffset: 20, upperStartOffset: 5, upperEndOffset: 10)
        XCTAssert(fullValueOffset == -5)
    }
}
