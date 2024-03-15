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
        let router = HomeRouter(delegate: homeDelegate)
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}
