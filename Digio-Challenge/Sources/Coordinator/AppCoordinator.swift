import Foundation

final class AppCoordinator: Coordinator {
    
    private let mainCoordinator: MainCoordinator = {
        let coordinator = MainCoordinator()
        return coordinator
    }()
    
    override init() {
        super.init()
        viewController = mainCoordinator.rootViewController
    }
    
    func start() {
        mainCoordinator.start()
    }
}
