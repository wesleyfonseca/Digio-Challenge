import Foundation

@testable import Digio_Challenge

final class HomeRouterInterfaceSpy: HomeRouterInterface {
    
    var showDetailCalled = false
    var showDetailParamsPassed: DetailDTO?
    func showDetail(data: DetailDTO) {
        showDetailCalled = true
        showDetailParamsPassed = data
    }
}
