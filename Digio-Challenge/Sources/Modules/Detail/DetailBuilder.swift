import Foundation

final class DetailBuilder {
    
    // MARK: - Methods
    func build() -> DetailViewController {
        let router = DetailRouter()
        let viewModel = DetailViewModel()
        let viewController = DetailViewController(router: router, viewModel: viewModel)
        return viewController
    }
}
