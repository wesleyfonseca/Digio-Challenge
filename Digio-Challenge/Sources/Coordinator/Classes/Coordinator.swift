import UIKit

class Coordinator: Coordinatable {
    var viewController = UIViewController()
}

extension Coordinatable where Self: Coordinator {
    var rootViewController: UIViewController {
        return viewController
    }
    
    func start() {
        fatalError("Implement in child")
    }
}
