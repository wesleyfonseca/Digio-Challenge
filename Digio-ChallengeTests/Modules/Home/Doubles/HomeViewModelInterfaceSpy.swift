import Foundation

@testable import Digio_Challenge

final class HomeViewModelInterfaceSpy: HomeViewModelInterface {
    
    var numberOfRows: Int = 1
    var headerViewConfiguration: HomeHeaderView.Configuration = .init(imageIcon: "ic_header", name: "Ipsum")
    var delegate: HomeViewModelDelegate?
    
    var fetchDataCalled = false
    func fetchData() {
        fetchDataCalled = true
    }
    
    var tableCellConfigurationCalled = false
    var tableCellConfigurationParamsPassed: HomeRowsType?
    var tableCellConfigurationReturn: HomeTableCell.Configuration?
    func tableCellConfiguration(rowType: HomeRowsType) -> HomeTableCell.Configuration? {
        tableCellConfigurationCalled = true
        tableCellConfigurationParamsPassed = rowType
        guard let tableCellConfigurationReturn else { return nil }
        return tableCellConfigurationReturn
    }
    
    var detailDataCalled = false
    var detailDataParamsPassed: (collectionConfiguration: HomeCollectionCell.Configuration, index: Int)?
    var detailDataReturn: DetailDTO?
    func detailData(collectionConfiguration: HomeCollectionCell.Configuration, index: Int) -> DetailDTO? {
        detailDataCalled = true
        detailDataParamsPassed = (collectionConfiguration: collectionConfiguration, index: index)
        return detailDataReturn
    }
}
