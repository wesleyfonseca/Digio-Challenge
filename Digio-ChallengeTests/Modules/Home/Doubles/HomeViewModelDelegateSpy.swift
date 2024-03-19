import Foundation

@testable import Digio_Challenge

final class HomeViewModelDelegateSpy: HomeViewModelDelegate {
    
    var fetchDataWithSuccessCalled = false
    func fetchDataWithSuccess() {
        fetchDataWithSuccessCalled = true
    }
    
    var fetchDataWithErrorCalled = false
    var fetchDataWithErrorParamsPassed: String?
    func fetchDataWithError(message: String) {
        fetchDataWithErrorCalled = true
        fetchDataWithErrorParamsPassed = message
    }
}
