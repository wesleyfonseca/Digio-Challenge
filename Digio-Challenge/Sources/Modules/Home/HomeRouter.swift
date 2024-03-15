import Foundation

protocol HomeRouterInterface: AnyObject {
    func showDetail()
}

protocol HomeRouterDelegate: AnyObject {
    func navigateToDetail()
}

final class HomeRouter: HomeRouterInterface {
        
    // MARK: - Properties
    private weak var delegate: HomeRouterDelegate?
    
    // MARK: - Init
    init(delegate: HomeRouterDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Methods
    func showDetail() {
        delegate?.navigateToDetail()
    }
}
