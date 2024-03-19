import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let productDetailView: ProductDetailView = {
        let view = ProductDetailView()
        view.isHidden = true
        return view
    }()
    
    private let bannerDetailView: BannerDetailView = {
        let view = BannerDetailView()
        view.isHidden = true
        return view
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
        setupView()
        build()
    }
    
    // MARK: - Methods
    private func build() {
        titleLabel.text = viewModel.detailTitle
        
        if viewModel.type == .products {
            productDetailView.build(configuration: viewModel.productDetailConfiguration)
            productDetailView.isHidden = false
        } else {
            bannerDetailView.build(configuration: viewModel.bannerDetailConfiguration)
            bannerDetailView.isHidden = false
        }
    }
}

// MARK: - ViewCodeProtocol
extension DetailViewController: ViewCodeProtocol {
    func buildViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(lineView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(productDetailView)
        stackView.addArrangedSubview(bannerDetailView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0)
        ])
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            lineView.heightAnchor.constraint(equalToConstant: 1.0)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {
        view.backgroundColor = .white
    }
}
