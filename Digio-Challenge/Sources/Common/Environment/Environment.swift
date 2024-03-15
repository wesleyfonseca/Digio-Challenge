import Foundation

protocol EnvironmentInterface: AnyObject {
    var domainURL: URL { get }
}

final class Environment: EnvironmentInterface {
    
    var domainURL: URL {
        if let domainURL = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox") {
            return domainURL
        } else {
            preconditionFailure("It's not a valid url")
        }
    }
}
