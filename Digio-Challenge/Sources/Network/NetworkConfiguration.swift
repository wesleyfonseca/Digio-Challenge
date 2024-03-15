import Foundation

final class NetworkConfiguration {
    
    // MARK: - Properties
    let environment = Environment()
    
    // MARK: - Methods
    func defaultHeaders() -> [String: String] {
        let headers = [
            "Plataform": "iOS",
            "Content-Type": "Application/json"
        ]
        return headers
    }
}
