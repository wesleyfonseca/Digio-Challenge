import Foundation
import XCTest

@testable import Digio_Challenge

final class NetworkRequestableSpy: NetworkRequestable {
    
    enum ServiceState {
        case success
        case failure
    }
    
    var serviceState: ServiceState = .success
    func request<DataType>(
        endpoint: NetworkEndpoint,
        completion: @escaping (Result<DataType?, NetworkErrorType>) -> Void)
    where DataType: Decodable, DataType: Encodable {
        
        switch serviceState {
        case .success:
            completion(.success(HomeDTO(
                spotlight: [
                    .init(name: "Recarga", bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png", description: "Agora ficou mais fÃ¡cil colocar crÃ©ditos no seu celular! A digio Store traz a facilidade de fazer recargas... direto pelo seu aplicativo, com toda seguranÃ§a e praticidade que vocÃª procura."),
                    .init(name: "Uber", bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png", description: "DÃª um vale presente Uber para amigos e familiares, ou use os vales para adicionar crÃ©ditos Ã  sua conta. O app Uber conecta vocÃª a uma viagem confiÃ¡vel em apenas alguns minutos. VocÃª pode escolher entre as opÃ§Ãµes econÃ´micas ou Premium para viajar do seu jeito. O pagamento Ã© fÃ¡cil e sem complicaÃ§Ãµes!")
                ],
                products: [
                    .init(name: "XBOX", imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/xbox_icon.png", description: "Com o e-Gift Card Xbox vocÃª adquire crÃ©ditos para comprar games, mÃºsica, filmes, programas de TV e muito mais!")
                ],
                cash: .init(title: "digio Cash", bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png", description: "Dinheiro na conta sem complicaÃ§Ã£o. Transfira parte do limite do seu cartÃ£o para sua conta.")
            ) as? DataType))
        case .failure:
            completion(.failure(.unknown))
        }
    }
}
