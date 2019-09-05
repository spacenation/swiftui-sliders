@testable import Sliders
import XCTest

class SliderMathDistanceFromZeroTests: XCTestCase {
    
    func testDistanceFromZero() {
        
        /// Zero value distance without offsets should be 0
        let zeroDistance = distanceFromZero(overallLength: 100, value: 0.0)
        XCTAssert(zeroDistance == 0)
        
        /// Middle value distance without offsets should be half of overall length
        let middleDistance = distanceFromZero(overallLength: 100, value: 0.5)
        XCTAssert(middleDistance == 50)
        
        /// Largest value distance without offsets should be full overall length
        let fullDistance = distanceFromZero(overallLength: 100, value: 1.0)
        XCTAssert(fullDistance == 100)
    }
    
    func testDistanceFromZeroWithNonUnitIntervalBounds() {
        
        /// Smallest value point distance without offsets should be 0
        let zeroDistance = distanceFromZero(overallLength: 100, value: 0.25, bounds: 0.25...1.25)
        XCTAssert(zeroDistance == 0)
        
        /// Middle value distance without offsets should be half of overall length
        let middleDistance = distanceFromZero(overallLength: 100, value: 3.0, bounds: 2.0...4.0)
        XCTAssert(middleDistance == 50)
        
        /// Largest value distance without offsets should be full overall length
        let fullDistance = distanceFromZero(overallLength: 100, value: 1.0, bounds: -1.0...1.0)
        XCTAssert(fullDistance == 100)
    }
    
    func testDistanceFromZeroWithOffsets() {
        
        /// Zero value distance with start offset 5 should be 5
        let zeroDistance = distanceFromZero(overallLength: 100, value: 0.0, startOffset: 5, endOffset: 0)
        XCTAssert(zeroDistance == 5)
        
        /// Middle value distance with start and end offset of 10 should be half of overall length
        let middleDistance = distanceFromZero(overallLength: 100, value: 0.5, startOffset: 10, endOffset: 10)
        XCTAssert(middleDistance == 50)
        
        /// Largest value distance with end offset of 5 should be full overall length minus end offset
        let fullDistance = distanceFromZero(overallLength: 100, value: 1.0, startOffset: 0, endOffset: 5)
        XCTAssert(fullDistance == 95)
    }
    
    func testDistanceFromZeroWithNonUnitIntervalBoundsWithOffsets() {
        
        /// Smallest value point distance with start offset 5 should be 5
        let zeroDistance1 = distanceFromZero(overallLength: 100, value: 0.25, bounds: 0.25...1.25, startOffset: 5, endOffset: 0)
        XCTAssert(zeroDistance1 == 5)
        
        /// Smallest value point distance with start offset 5 and end offset of 5 should be 5
        let zeroDistance2 = distanceFromZero(overallLength: 100, value: 0.25, bounds: 0.25...1.25, startOffset: 5, endOffset: 5)
        XCTAssert(zeroDistance2 == 5)
        
        /// Middle value distance with equal offsets should be half of overall length
        let middleDistance1 = distanceFromZero(overallLength: 100, value: 3.0, bounds: 2.0...4.0, startOffset: 10, endOffset: 10)
        XCTAssert(middleDistance1 == 50)
        
        /// Middle value distance with different offsets should be half of overall length minus center point of these offsets
        let middleDistance2 = distanceFromZero(overallLength: 100, value: 3.0, bounds: 2.0...4.0, startOffset: 13, endOffset: 7)
        XCTAssert(middleDistance2 == 53)
        
        /// Middle value distance with different offsets should be half of overall length minus center point of these offsets
        let middleDistance3 = distanceFromZero(overallLength: 100, value: 3.0, bounds: 2.0...4.0, startOffset: 2, endOffset: 18)
        XCTAssert(middleDistance3 == 42)
        
        /// Largest value distance with end offset of 5 should be full overall length minus end offset
        let fullDistance1 = distanceFromZero(overallLength: 100, value: 1.0, bounds: -1.0...1.0, startOffset: 0, endOffset: 5)
        XCTAssert(fullDistance1 == 95)
        
        /// Largest value distance with both offsets of 5 should be full overall length minus end offset
        let fullDistance2 = distanceFromZero(overallLength: 100, value: 1.0, bounds: -1.0...1.0, startOffset: 5, endOffset: 5)
        XCTAssert(fullDistance2 == 95)
    }
    
}

