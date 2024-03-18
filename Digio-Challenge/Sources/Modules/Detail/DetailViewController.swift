import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let router: DetailRouterInterface
    private let viewModel: DetailViewModelInterface
    
    // MARK: - Init
    init(
        router: DetailRouterInterface,
        viewModel: DetailViewModelInterface
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
        view.backgroundColor = .systemGreen
        view.addSubview(titleLabel)
        titleLabel.pinToBounds(of: view)
    }
    
    // MARK: - Methods
    func updateTitle(_ text: String) {
        titleLabel.text = text
    }
}
