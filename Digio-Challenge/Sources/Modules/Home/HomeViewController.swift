import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Properties
    private let headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeTableCell.self, forCellReuseIdentifier: String(describing: HomeTableCell.self))
        return tableView
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
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.pinToBounds(of: view)
    }
    
    func setupAditionalConfiguration() {
        view.backgroundColor = .white
        navigationItem.titleView = headerView
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableCell.self), for: indexPath) as? HomeTableCell else {
            return UITableViewCell()
        }
        
        cell.build(configuration: .init(
            title: "boa",
            collectionConfiguration: .init(type: .products))
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func fetchDataWithSuccess() {
        DispatchQueue.main.async {
            self.headerView.build(configuration: self.viewModel.headerViewConfiguration)
            self.tableView.reloadData()
        }
    }
    
    func fetchDataWithError(message: String) {
        print("Failure")
    }
}
