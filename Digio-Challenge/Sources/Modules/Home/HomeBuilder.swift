import Foundation

final class HomeBuilder {
    
    // MARK: - Properties
    private weak var homeDelegate: HomeRouterDelegate?
    
    // MARK: - Init
    init(delegate: HomeRouterDelegate?) {
        self.homeDelegate = delegate
    }
    
    // MARK: - Methods
    func build() -> HomeViewController {
        let service = NetworkRequestService()
        let router = HomeRouter(delegate: homeDelegate)
        let viewModel = HomeViewModel(service: service)
        let viewController = HomeViewController(router: router, viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}
