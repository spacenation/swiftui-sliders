@testable import Sliders
import XCTest

class SliderMathValueFromTests: XCTestCase {
    
    func testValueFrom() {
        /// Unit interval value of relative should be itself
        let zeroValue = valueFrom(relativeValue: 0.0)
        XCTAssert(zeroValue == 0.0)
        
        /// Unit interval value of relative should be itself
        let middleValue = valueFrom(relativeValue: 0.5)
        XCTAssert(middleValue == 0.5)
        
        /// Unit interval value of relative should be itself
        let fullValue = valueFrom(relativeValue: 1.0)
        XCTAssert(fullValue == 1.0)
    }
    
    func testValueFromWithBounds() {
        let zeroValue = valueFrom(relativeValue: 0.0, bounds: 0.25...1.25)
        XCTAssert(zeroValue == 0.25)
        
        let middleValue = valueFrom(relativeValue: 0.5, bounds: -1.0...1.0)
        XCTAssert(middleValue == 0.0)
        
        let fullValue = valueFrom(relativeValue: 1.0, bounds: -3.0...3.0)
        XCTAssert(fullValue == 3.0)
    }
    
    func testValueFromWithBoundsAndStep() {
        let zeroValue = valueFrom(relativeValue: 0.0, bounds: 25...125, step: 10)
        XCTAssert(zeroValue == 30)
        
        let middleValue = valueFrom(relativeValue: 0.5, bounds: -1.0...1.0, step: 1)
        XCTAssert(middleValue == 0.0)
        
        let fullValue = valueFrom(relativeValue: 1.0, bounds: -3.0...3.0, step: 0.5)
        XCTAssert(fullValue == 3.0)
    }
}
