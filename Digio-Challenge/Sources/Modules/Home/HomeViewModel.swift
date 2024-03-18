import Foundation

protocol HomeViewModelInterface: AnyObject {
    var numberOfRows: Int { get }
    var headerViewConfiguration: HomeHeaderView.Configuration { get }
    var delegate: HomeViewModelDelegate? { get set }
    
    func fetchData()
    func tableCellConfiguration(indexPath: IndexPath) -> HomeTableCell.Configuration?
}

protocol HomeViewModelDelegate: AnyObject {
    func fetchDataWithSuccess()
    func fetchDataWithError(message: String)
}

final class HomeViewModel: HomeViewModelInterface {
    
    // MARK: - Properties
    var numberOfRows: Int {
        return 3
    }
    
    var headerViewConfiguration: HomeHeaderView.Configuration {
        return .init(
            imageIcon: "ic_header",
            name: "Maria"
        )
    }
    
    private var spotlightViewConfiguration: HomeTableCell.Configuration? {
        guard let data else { return nil }
        
        return .init(collectionConfiguration: .init(
            type: .spotlight,
            spotlightConfiguration: data.spotlight)
        )
    }
    
    private var cashViewConfiguration: HomeTableCell.Configuration? {
        guard let data else { return nil }
        
        return .init(
            title: "digio Cash",
            collectionConfiguration: .init(
            type: .cash,
            cashConfiguration: data.cash)
        )
    }
    
    private var productsViewConfiguration: HomeTableCell.Configuration? {
        guard let data else { return nil }
        
        return .init(
            title: "Produtos",
            collectionConfiguration: .init(
            type: .products,
            productsConfiguration: data.products)
        )
    }
    
    private var data: HomeDTO?
    private let service: NetworkRequestable
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - Init
    init(service: NetworkRequestable) {
        self.service = service
    }
    
    // MARK: - Methods
    func fetchData() {
        let endpoint = HomeEndpoint()
        service.request(endpoint: endpoint) { [weak self] (result: Result<HomeDTO?, NetworkErrorType>) in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                guard let response = response else {
                    return
                }
                data = response
                delegate?.fetchDataWithSuccess()
            case .failure(let error):
                delegate?.fetchDataWithError(message: error.localizedDescription)
            }
        }
    }
    
    func tableCellConfiguration(indexPath: IndexPath) -> HomeTableCell.Configuration? {
        switch indexPath.row {
        case 0:
            return spotlightViewConfiguration
        case 1:
            return cashViewConfiguration
        case 2:
            return productsViewConfiguration
        default:
            return nil
        }
    }
}
