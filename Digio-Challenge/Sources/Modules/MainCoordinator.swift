import Foundation

final class MainCoordinator: NavigationCoordinator {
    
    private let homeViewController: HomeViewController = {
        let vc = HomeViewController()
        return vc
    }()
    
    func start() {
        viewController.setViewControllers([homeViewController], animated: true)
    }
}
