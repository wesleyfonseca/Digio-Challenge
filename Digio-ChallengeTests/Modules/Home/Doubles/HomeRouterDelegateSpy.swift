import Foundation

@testable import Digio_Challenge

final class HomeRouterDelegateSpy: HomeRouterDelegate {
    
    var navigateToDetailCalled = false
    var navigateToDetailParamPassed: DetailDTO?
    func navigateToDetail(data: DetailDTO) {
        navigateToDetailCalled = true
        navigateToDetailParamPassed = data
    }
}
