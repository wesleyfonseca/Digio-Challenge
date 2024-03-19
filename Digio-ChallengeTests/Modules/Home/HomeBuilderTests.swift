import Foundation
import XCTest

@testable import Digio_Challenge

final class HomeBuilderTests: XCTestCase {
 
    private let delegateSpy = HomeRouterDelegateSpy()
    
    private lazy var sut: HomeBuilder = {
        let sut = HomeBuilder(delegate: delegateSpy)
        return sut
    }()
    
    func test_build_shouldSetupCorrectly() {
        let build = sut.build()
        
        XCTAssertNotNil(build)
        XCTAssertTrue(build.isKind(of: HomeViewController.self))
    }
}
