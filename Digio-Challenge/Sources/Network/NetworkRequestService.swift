import Foundation

final class NetworkRequestService: NetworkRequestable {
    
    // MARK: - Properties
    private var task: URLSessionDataTask?
    
    // MARK: - Methods
    func request<DataType>(
        endpoint: NetworkEndpoint,
        completion: @escaping (Result<DataType?, NetworkErrorType>) -> Void
    ) where DataType : Decodable, DataType : Encodable {
        guard let request = endpoint.createRequest() else {
            completion(.failure(.unknown))
            return
        }
        
        let session = createSession()
        task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            session.finishTasksAndInvalidate()
            
            guard let httpResponse = response as? HTTPURLResponse, let data else {
                completion(.failure(.unknown))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decodedData: DataType = try JSONDecoder().decode(DataType.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("\(NetworkErrorType.decodingError) \(error.localizedDescription)")
                    completion(.failure(.decodingError))
                }
            } else {
                print("Status Code: \(httpResponse.statusCode)")
            }
        })
        
        task?.resume()
    }
    
    private func createSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration)
    }
}
