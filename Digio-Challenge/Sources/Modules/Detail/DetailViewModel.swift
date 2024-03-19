import Foundation

protocol DetailViewModelInterface: AnyObject {
    var detailTitle: String { get }
    var type: HomeCollectionCell.HomeCollectionCellType { get }
    var productDetailConfiguration: ProductDetailView.Configuration { get }
    var bannerDetailConfiguration: BannerDetailView.Configuration { get }
}

final class DetailViewModel: DetailViewModelInterface {
    
    // MARK: - Properties
    var detailTitle: String {
        return detailData.title
    }
    
    var type: HomeCollectionCell.HomeCollectionCellType {
        return detailData.type
    }
    
    var productDetailConfiguration: ProductDetailView.Configuration {
        return .init(
            imageUrl: detailData.imageUrl,
            name: detailData.name,
            description: detailData.description
        )
    }
    
    var bannerDetailConfiguration: BannerDetailView.Configuration {
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
