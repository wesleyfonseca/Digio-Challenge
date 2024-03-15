import Foundation

protocol NetworkEndpoint: AnyObject {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var headers: [String: String] { get }
}

extension NetworkEndpoint {
    func createRequest() -> NSMutableURLRequest? {
        guard let requestURL = createURL() else {
            return nil
        }
        
        let request = NSMutableURLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 20
        headers.forEach({ request.setValue($0.value, forHTTPHeaderField: $0.key) })
        return request
    }
    
    private func createURL() -> URL? {
        var requestURL = URLComponents()
        requestURL.scheme = baseURL.scheme
        requestURL.host = baseURL.host
        requestURL.port = baseURL.port
        requestURL.path = path
        
        if !baseURL.path.isEmpty {
            requestURL.path = baseURL.path + requestURL.path
        }
        
        return requestURL.url
    }
}
