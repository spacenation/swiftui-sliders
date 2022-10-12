@testable import Sliders
import XCTest

class RangeDistanceTests: XCTestCase {
    
    func testRangeDistance() {
        let zeroRangeDistance = rangeDistance(overallLength: 100, range: 0.5...0.5)
        XCTAssert(zeroRangeDistance == 0)
        
        let halfRangeDistance = rangeDistance(overallLength: 100, range: 0.25...0.75)
        XCTAssert(halfRangeDistance == 50)
        
        let fullRangeDistance = rangeDistance(overallLength: 100, range: 0.0...1.0)
        XCTAssert(fullRangeDistance == 100)
    }
    
    func testRangeDistanceWithBounds() {
        let zeroRangeDistance = rangeDistance(overallLength: 100, range: 0.5...0.5, bounds: 0.25...1.25)
        XCTAssert(zeroRangeDistance == 0)
        
        let halfRangeDistance = rangeDistance(overallLength: 100, range: -0.5...0.5, bounds: -1.0...1.0)
        XCTAssert(halfRangeDistance == 50)
        
        let fullRangeDistance = rangeDistance(overallLength: 100, range: -2.0...2.0, bounds: -2.0...2.0)
        XCTAssert(fullRangeDistance == 100)
    }
    
    func testRangeDistanceWithBoundsAndOffsets() {
        
        let zeroRangeDistance = rangeDistance(overallLength: 100, range: 0.5...0.5, bounds: 0.25...1.25, lowerStartOffset: 10, lowerEndOffset: 10, upperStartOffset: 10, upperEndOffset: 10)
        XCTAssert(zeroRangeDistance == 0)
        
        let halfRangeDistance = rangeDistance(overallLength: 100, range: -0.5...0.5, bounds: -1.0...1.0, lowerStartOffset: 15, lowerEndOffset: 5, upperStartOffset: 15, upperEndOffset: 5)
        XCTAssert(halfRangeDistance == 40)
        
        let fullRangeDistance = rangeDistance(overallLength: 100, range: -2.0...2.0, bounds: -2.0...2.0, lowerStartOffset: 5, lowerEndOffset: 15, upperStartOffset: 5, upperEndOffset: 15)
        XCTAssert(fullRangeDistance == 80)
    }
    
    func testRangeUpdatingLowerBoundWithUnlimitedDistance() {
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.0, upperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: true),
            0.0 ... 1.0
        )
        
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.5, upperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: true),
            0.5 ... 0.5
        )
        
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.6, upperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: true),
            0.6 ... 0.6
        )
        
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.0, upperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: false),
            0.0 ... 1.0
        )
        
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.5, upperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: false),
            0.5 ... 0.5
        )
        
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.6, upperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: false),
            0.5 ... 0.5
        )
    }
    
    func testRangeUpdatingUpperBoundWithUnlimitedDistance() {
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.0, updatedUpperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: true),
            0.0 ... 1.0
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: true),
            0.5 ... 0.5
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.4, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: true),
            0.4 ... 0.4
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.0, updatedUpperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: false),
            0.0 ... 1.0
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: false),
            0.5 ... 0.5
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.4, bounds: 0.0 ... 1.0, distance: 0.0 ... 1.0, forceAdjacent: false),
            0.5 ... 0.5
        )
    }
    
    func testRangeUpdatingLowerBoundWithDistance() {
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.95, upperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true),
            0.9 ... 1.0
        )
        
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.0, upperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true),
            0.0 ... 0.5
        )
        
        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.5, upperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true),
            0.5 ... 0.6
        )

        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.6, upperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true),
            0.6 ... 0.7
        )

        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.0, upperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: false),
            0.0 ... 0.5
        )

        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.5, upperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: false),
            0.4 ... 0.5
        )

        XCTAssertEqual(
            rangeFrom(updatedLowerBound: 0.6, upperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: false),
            0.4 ... 0.5
        )
    }
    
    func testRangeUpdatingUpperBoundWithDistance() {
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.0, updatedUpperBound: 0.05, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true),
            0.0 ... 0.1
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.0, updatedUpperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true),
            0.5 ... 1.0
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true),
            0.4 ... 0.5
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.4, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true).lowerBound,
            0.3,
            accuracy: 0.0001
        )
        
        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.4, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: true).upperBound,
            0.4,
            accuracy: 0.0001
        )

        XCTAssertEqual(
            rangeFrom(lowerBound: 0.0, updatedUpperBound: 1.0, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: false),
            0.5 ... 1.0
        )

        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.5, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: false),
            0.5 ... 0.6
        )

        XCTAssertEqual(
            rangeFrom(lowerBound: 0.5, updatedUpperBound: 0.4, bounds: 0.0 ... 1.0, distance: 0.1 ... 0.5, forceAdjacent: false),
            0.5 ... 0.6
        )
    }
}
