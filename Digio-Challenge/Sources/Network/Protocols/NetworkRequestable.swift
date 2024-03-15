import Foundation

protocol NetworkRequestable: AnyObject {
    func request<DataType: Codable>(
        endpoint: NetworkEndpoint,
        completion: @escaping (Result<DataType?, NetworkErrorType>) -> Void
    )
}
