import Foundation
import XCTest

@testable import Digio_Challenge

final class HomeRouterTests: XCTestCase {
    
    private let delegateSpy = HomeRouterDelegateSpy()
    
    private lazy var sut: HomeRouter = {
        let sut = HomeRouter(delegate: delegateSpy)
        return sut
    }()
    
    // MARK: - Tests
    func test_detail_shouldShowDetail() {
        sut.showDetail(data: DetailDTO(type: .spotlight, title: "title", name: "name", description: "description", imageUrl: "http://banner"))
        
        XCTAssertTrue(delegateSpy.navigateToDetailCalled)
        XCTAssertEqual(delegateSpy.navigateToDetailParamPassed?.title, "title")
        XCTAssertEqual(delegateSpy.navigateToDetailParamPassed?.name, "name")
        XCTAssertEqual(delegateSpy.navigateToDetailParamPassed?.description, "description")
        XCTAssertEqual(delegateSpy.navigateToDetailParamPassed?.imageUrl, "http://banner")
    }
}
