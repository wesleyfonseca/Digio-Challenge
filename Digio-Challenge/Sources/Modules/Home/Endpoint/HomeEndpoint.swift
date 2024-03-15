import Foundation

final class HomeEndpoint: NetworkEndpoint {
    
    // MARK: - Properties
    var baseURL: URL {
        return networkConfiguration.environment.domainURL
    }
    
    var path: String {
        return "/products"
    }
    
    var method: NetworkMethod {
        return .get
    }
    
    var headers: [String : String] {
        networkConfiguration.defaultHeaders()
    }
    
    private let networkConfiguration: NetworkConfiguration
    
    // MARK: - Init
    init(networkConfiguration: NetworkConfiguration = NetworkConfiguration()) {
        self.networkConfiguration = networkConfiguration
    }
}
