import Foundation
import XCTest
import SnapshotTesting

@testable import Digio_Challenge

final class HomeViewControllerSnapshot: XCTestCase {
    
    private let routerSpy = HomeRouterInterfaceSpy()
    private let viewModelSpy = HomeViewModelInterfaceSpy()
    
    private lazy var sut: HomeViewController = {
        let sut = HomeViewController(
            router: routerSpy,
            viewModel: viewModelSpy
        )
        return sut
    }()
    
    private let headerView: HomeHeaderView = {
        let header = HomeHeaderView()
        header.build(configuration: .init(imageIcon: "ic_header", name: "Profile Name"))
        return header
    }()
    
    // MARK: - Tests
    func test_snapshot_shouldRenderHeaderViewCorrectly() {
        sut.viewDidLoad()
        sut.fetchDataWithSuccess()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        view.addSubview(headerView)
        view.backgroundColor = .white
        headerView.pinToBounds(of: view)
        
        assertSnapshot(matching: view, as: .image)
    }
}
