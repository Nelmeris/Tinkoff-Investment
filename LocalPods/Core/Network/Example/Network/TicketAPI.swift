//
//  TicketAPI.swift
//  Network_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Network

public enum TicketAPI {
    case stockSymbol(exchange: String)
    
    var apiKey: String { return "bpkpa07rh5rcgrlrc06g" }
}

extension TicketAPI: INetworkAPI {
    public var schema: NetworkSchema { return .https }
    
    public var host: String { return "finnhub.io/api/v1" }
    
    public var path: String {
        switch self {
        case .stockSymbol: return "/stock/symbol"
        }
    }
    
    public var httpMethod: HTTPMethod {
        switch self {
        case .stockSymbol: return .get
        }
    }
    
    public var task: HTTPTask {
        switch self {
        case .stockSymbol(let exchange):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["exchange": exchange,
                                                      "token": apiKey])
        }
    }
    
    public var headers: HTTPHeaders? { return nil }
}
