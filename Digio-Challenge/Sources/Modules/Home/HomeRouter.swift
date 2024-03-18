import Foundation

protocol HomeRouterInterface: AnyObject {
    func showDetail(data: DetailDTO)
}

protocol HomeRouterDelegate: AnyObject {
    func navigateToDetail(data: DetailDTO)
}

final class HomeRouter: HomeRouterInterface {
        
    // MARK: - Properties
    private weak var delegate: HomeRouterDelegate?
    
    // MARK: - Init
    init(delegate: HomeRouterDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: - Methods
    func showDetail(data: DetailDTO) {
        delegate?.navigateToDetail(data: data)
    }
}
