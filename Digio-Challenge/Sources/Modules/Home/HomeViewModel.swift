import Foundation

protocol HomeViewModelInterface: AnyObject {
    var headerViewConfiguration: HomeHeaderView.Configuration { get }
    var delegate: HomeViewModelDelegate? { get set }
    
    func fetchData()
}

protocol HomeViewModelDelegate: AnyObject {
    func fetchDataWithSuccess()
    func fetchDataWithError(message: String)
}

final class HomeViewModel: HomeViewModelInterface {
    
    // MARK: - Properties
    var headerViewConfiguration: HomeHeaderView.Configuration {
        return .init(
            imageIcon: "ic_header",
            name: "Maria"
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
}
