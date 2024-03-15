import Foundation

final class MainCoordinator: NavigationCoordinator {
    
    private lazy var homeBuilder: HomeBuilder = {
        let homeBuilder = HomeBuilder(delegate: self)
        return homeBuilder
    }()
    
    func start() {
        viewController.setViewControllers([homeBuilder.build()], animated: true)
    }
}

// MARK: - HomeRouterDelegate
extension MainCoordinator: HomeRouterDelegate {
    func navigateToDetail() {
        
    }
}
