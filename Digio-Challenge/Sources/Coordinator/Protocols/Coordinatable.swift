import UIKit

protocol Coordinatable: AnyObject {
    var rootViewController: UIViewController { get }
    
    func start()
}
