import Foundation

protocol DetailViewModelInterface: AnyObject {
    var detailTitle: String { get }
    var productDetailConfiguration: ProductDetailView.Configuration { get }
}

final class DetailViewModel: DetailViewModelInterface {
    
    // MARK: - Properties
    var detailTitle: String {
        return detailData.title
    }
    
    var productDetailConfiguration: ProductDetailView.Configuration {
        return .init(
            imageUrl: detailData.imageUrl,
            name: detailData.name,
            description: detailData.description
        )
    }
    
    private let detailData: DetailDTO
    
    // MARK: - Init
    init(detailData: DetailDTO) {
        self.detailData = detailData
    }
    
    // MARK: - Methods
}
