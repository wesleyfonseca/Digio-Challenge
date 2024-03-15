import UIKit

class NavigationCoordinator: Coordinatable {
    var viewController = UINavigationController()
}

extension Coordinatable where Self: NavigationCoordinator {
    var rootViewController: UIViewController {
        return viewController
    }
    
    func start() {
        fatalError("Implement in child")
    }
}
