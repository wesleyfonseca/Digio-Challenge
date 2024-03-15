import Foundation

struct HomeDTO: Codable {
    
    // MARK: - Properties
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}

struct Spotlight: Codable {
    
    // MARK: - Properties
    let name: String
    let bannerURL: String
    let description: String
}

struct Product: Codable {
    
    // MARK: - Properties
    let name: String
    let imageURL: String
    let description: String
}

struct Cash: Codable {
    
    // MARK: - Properties
    let title: String
    let bannerURL: String
    let description: String
}
