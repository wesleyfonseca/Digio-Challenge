import Foundation

protocol HomeViewModelInterface: AnyObject {
    var numberOfRows: Int { get }
    var headerViewConfiguration: HomeHeaderView.Configuration { get }
    var delegate: HomeViewModelDelegate? { get set }
    
    func fetchData()
    func tableCellConfiguration(rowType: HomeRowsType) -> HomeTableCell.Configuration?
    func detailData(collectionConfiguration: HomeCollectionCell.Configuration, index: Int) -> DetailDTO?
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
    
    func tableCellConfiguration(rowType: HomeRowsType) -> HomeTableCell.Configuration? {
        switch rowType {
        case .spotlight:
            return spotlightViewConfiguration
        case .cash:
            return cashViewConfiguration
        case .products:
            return productsViewConfiguration
        }
    }
    
    func detailData(collectionConfiguration: HomeCollectionCell.Configuration, index: Int) -> DetailDTO? {
        guard let data else { return nil }
        
        switch collectionConfiguration.type {
        case .spotlight:
            let dataSpotlight = data.spotlight[index]
            let detailData = DetailDTO(
                type: collectionConfiguration.type,
                title: "Spotlight",
                name: dataSpotlight.name,
                description: dataSpotlight.description,
                imageUrl: dataSpotlight.bannerURL
            )
            return detailData
        case .cash:
            let dataSpotlight = data.cash
            let detailData = DetailDTO(
                type: collectionConfiguration.type,
                title: "digio Cash",
                name: dataSpotlight.title,
                description: dataSpotlight.description,
                imageUrl: dataSpotlight.bannerURL
            )
            return detailData
        case .products:
            let dataSpotlight = data.products[index]
            let detailData = DetailDTO(
                type: collectionConfiguration.type,
                title: "Produto",
                name: dataSpotlight.name,
                description: dataSpotlight.description,
                imageUrl: dataSpotlight.imageURL
            )
            return detailData
        }
    }
}

enum HomeRowsType: Int {
    case spotlight
    case cash
    case products
}
