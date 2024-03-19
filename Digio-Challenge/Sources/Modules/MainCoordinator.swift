import Foundation

final class MainCoordinator: NavigationCoordinator {
    
    private lazy var homeBuilder: HomeBuilder = {
        let homeBuilder = HomeBuilder(delegate: self)
        return homeBuilder
    }()
    
    private let detailBuilder: DetailBuilder = {
        let detailBuilder = DetailBuilder()
        return detailBuilder
    }()
    
    func start() {
        viewController.setViewControllers([homeBuilder.build()], animated: true)
    }
}

// MARK: - HomeRouterDelegate
extension MainCoordinator: HomeRouterDelegate {
    func navigateToDetail(data: DetailDTO) {
        let detailViewController = detailBuilder.build(detailData: data)
        viewController.pushViewController(detailViewController, animated: true)
    }
}
