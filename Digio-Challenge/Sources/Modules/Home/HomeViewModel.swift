import Foundation

protocol HomeViewModelInterface: AnyObject {
    var delegate: HomeViewModelDelegate? { get set }
}

protocol HomeViewModelDelegate: AnyObject {
    
}

final class HomeViewModel: HomeViewModelInterface {
    
    // MARK: - Properties
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - Init
    init() {}
    
    // MARK: - Methods
    
}
