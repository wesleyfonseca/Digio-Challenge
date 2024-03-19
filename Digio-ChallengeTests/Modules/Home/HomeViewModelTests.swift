import Foundation
import XCTest

@testable import Digio_Challenge

final class HomeViewModelTests: XCTestCase {
    
    private let serviceSpy = NetworkRequestableSpy()
    private let delegateSpy = HomeViewModelDelegateSpy()
    
    private lazy var sut: HomeViewModel = {
        let sut = HomeViewModel(service: serviceSpy)
        sut.delegate = delegateSpy
        return sut
    }()
    
    // MARK: - Tests
    func test_validateReference_shouldBeCorrectly() {
        XCTAssertNotNil(sut)
    }
    
    func test_makeRequest_shouldFetchDataWithSuccess() {
        serviceSpy.serviceState = .success
        sut.fetchData()
        XCTAssertTrue(delegateSpy.fetchDataWithSuccessCalled)
    }
    
    func test_makeRequest_shouldFetchDataWithError() {
        serviceSpy.serviceState = .failure
        sut.fetchData()
        XCTAssertTrue(delegateSpy.fetchDataWithErrorCalled)
        XCTAssertEqual(delegateSpy.fetchDataWithErrorParamsPassed, NetworkErrorType.unknown.localizedDescription)
    }
    
    func test_tableCell_shouldConfigurSpotlight() {
        serviceSpy.serviceState = .success
        sut.fetchData()
        let spotlightConfig = sut.tableCellConfiguration(rowType: HomeRowsType(rawValue: 0) ?? .spotlight)
        XCTAssertNotNil(spotlightConfig)
        XCTAssertNotNil(spotlightConfig?.collectionConfiguration.spotlightConfiguration)
        XCTAssertNil(spotlightConfig?.collectionConfiguration.cashConfiguration)
        XCTAssertNil(spotlightConfig?.collectionConfiguration.productsConfiguration)
        XCTAssertEqual(spotlightConfig?.collectionConfiguration.type, .spotlight)
    }
    
    func test_tableCell_shouldConfigurCash() {
        serviceSpy.serviceState = .success
        sut.fetchData()
        let cashConfig = sut.tableCellConfiguration(rowType: HomeRowsType(rawValue: 1) ?? .spotlight)
        XCTAssertNotNil(cashConfig)
        XCTAssertNotNil(cashConfig?.collectionConfiguration.cashConfiguration)
        XCTAssertNil(cashConfig?.collectionConfiguration.spotlightConfiguration)
        XCTAssertNil(cashConfig?.collectionConfiguration.productsConfiguration)
        XCTAssertEqual(cashConfig?.collectionConfiguration.type, .cash)
    }
    
    func test_tableCell_shouldConfigurProducts() {
        serviceSpy.serviceState = .success
        sut.fetchData()
        let productsConfig = sut.tableCellConfiguration(rowType: HomeRowsType(rawValue: 2) ?? .spotlight)
        XCTAssertNotNil(productsConfig)
        XCTAssertNotNil(productsConfig?.collectionConfiguration.productsConfiguration)
        XCTAssertNil(productsConfig?.collectionConfiguration.spotlightConfiguration)
        XCTAssertNil(productsConfig?.collectionConfiguration.cashConfiguration)
        XCTAssertEqual(productsConfig?.collectionConfiguration.type, .products)
    }
    
    func test_detailData_shouldConfigureSpotlight() {
        serviceSpy.serviceState = .success
        sut.fetchData()
        let detailData = sut.detailData(collectionConfiguration: .init(type: .spotlight), index: 0)
        XCTAssertEqual(detailData?.type, .spotlight)
        XCTAssertEqual(detailData?.title, "Spotlight")
        XCTAssertEqual(detailData?.name, "Recarga")
        XCTAssertEqual(detailData?.imageUrl, "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png")
        XCTAssertEqual(detailData?.description, "Agora ficou mais fÃ¡cil colocar crÃ©ditos no seu celular! A digio Store traz a facilidade de fazer recargas... direto pelo seu aplicativo, com toda seguranÃ§a e praticidade que vocÃª procura.")
    }
}
