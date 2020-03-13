//
//  FinnhubAPI.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//

import Network

public enum FinnhubAPI {
    case stockSymbol(exchange: String)
    case stockExchange
    
    var apiKey: String { "bpkpa07rh5rcgrlrc06g" }
}

extension FinnhubAPI: INetworkAPI {
    public var schema: NetworkSchema { .https }
    
    public var host: String { "finnhub.io/api/v1" }
    
    public var path: String {
        switch self {
        case .stockSymbol: return "/stock/symbol"
        case .stockExchange: return "/stock/exchange"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .stockSymbol, .stockExchange: return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .stockSymbol(let exchange):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["exchange": exchange,
                                                      "token": apiKey])
        case .stockExchange:
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["token": apiKey])
        }
    }
    
    public var headers: HTTPHeaders? { nil }
}
