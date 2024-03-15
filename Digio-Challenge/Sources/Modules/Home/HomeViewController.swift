import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: HomeViewModelInterface
    
    // MARK: - Init
    init(viewModel: HomeViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    
}
