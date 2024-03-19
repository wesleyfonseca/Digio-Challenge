import Foundation

final class DetailBuilder {
    
    // MARK: - Methods
    func build(detailData: DetailDTO) -> DetailViewController {
        let router = DetailRouter()
        let viewModel = DetailViewModel(detailData: detailData)
        let viewController = DetailViewController(router: router, viewModel: viewModel)
        return viewController
    }
}
