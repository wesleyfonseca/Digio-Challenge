import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appCoordinator = AppCoordinator()
    
    lazy var window: UIWindow? = {
        return UIWindow()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.backgroundColor = .clear
        window?.makeKeyAndVisible()
        window?.rootViewController = appCoordinator.rootViewController
        appCoordinator.start()
        
        return true
    }

}

