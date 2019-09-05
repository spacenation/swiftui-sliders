@testable import Sliders
import XCTest

class SliderMathRelativeValueFromTests: XCTestCase {
    
    func testRelativeValueFrom() {
        /// Relative value of unit interval value should be itself
        let zeroRelativeValue = relativeValueFrom(value: 0.0)
        XCTAssert(zeroRelativeValue == 0.0)
        
        /// Relative value of unit interval value should be itself
        let middleRelativeValue = relativeValueFrom(value: 0.5)
        XCTAssert(middleRelativeValue == 0.5)
        
        /// Relative value of unit interval value should be itself
        let fullRelativeValue = relativeValueFrom(value: 1.0)
        XCTAssert(fullRelativeValue == 1.0)
    }
    
    func testRelativeValueFromWithBounds() {
        /// Relative value of
        let zeroRelativeValue = relativeValueFrom(value: 0.25, bounds: 0.25...1.25)
        XCTAssert(zeroRelativeValue == 0.0)
        
        let middleRelativeValue = relativeValueFrom(value: 0.0, bounds: -1.0...1.0)
        XCTAssert(middleRelativeValue == 0.5)
        
        let fullRelativeValue = relativeValueFrom(value: 3.0, bounds: -3.0...3.0)
        XCTAssert(fullRelativeValue == 1.0)
    }
    
    func testRelativeValueFromCenterOffset() {
        let centerRelativeValue1 = relativeValueFrom(overallLength: 100, centerOffset: 0)
        XCTAssert(centerRelativeValue1 == 0.5)
        
        let centerRelativeValue2 = relativeValueFrom(overallLength: 100, centerOffset: -10)
        XCTAssert(centerRelativeValue2 == 0.4)
        
        let centerRelativeValue3 = relativeValueFrom(overallLength: 100, centerOffset: 10)
        XCTAssert(centerRelativeValue3 == 0.6)
    }
}
