import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Properties
    private let headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        return view
    }()
    
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
        setupView()
        viewModel.fetchData()
    }
}

// MARK: - ViewCodeProtocol
extension HomeViewController: ViewCodeProtocol {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAditionalConfiguration() {
        view.backgroundColor = .white
        navigationItem.titleView = headerView
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func fetchDataWithSuccess() {
        DispatchQueue.main.async {
            self.headerView.build(configuration: self.viewModel.headerViewConfiguration)
        }
    }
    
    func fetchDataWithError(message: String) {
        print("Failure")
    }
}
