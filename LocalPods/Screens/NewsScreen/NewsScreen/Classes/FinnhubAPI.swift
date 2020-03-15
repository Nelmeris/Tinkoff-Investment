//
//  FinnhubAPI.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Network

enum FinnhubAPI: INetworkAPI {
    case news

    var apiKey: String { "bpkpa07rh5rcgrlrc06g" }
    var schema: NetworkSchema { .https }
    var host: String { "finnhub.io/api/v1" }
    var httpMethod: HTTPMethod { .get }
    var headers: HTTPHeaders? { nil }

    var path: String {
        switch self {
        case .news: return "news"
        }
    }

    var task: HTTPTask { .requestParameters(
        bodyParameters: nil,
        urlParameters: [
            "category": "general",
            "token": apiKey
        ])
    }

}
