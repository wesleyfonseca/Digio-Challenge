import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Properties
    private let router: HomeRouterInterface
    private let viewModel: HomeViewModelInterface
    
    // MARK: - Init
    init(
        router: HomeRouterInterface,
        viewModel: HomeViewModelInterface
    ) {
        self.router = router
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.fetchData()
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func fetchDataWithSuccess() {
        print("SUCCESS")
    }
    
    func fetchDataWithError(message: String) {
        print("Failure")
    }
}
