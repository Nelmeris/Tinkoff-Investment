//
//  ExchangeDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Network

public final class ExchangeDataManager: FinnhubDataManager<Exchange> {
    
    public func load(with symbol: String, completion: @escaping ((Result<[Exchange], NetworkError>) -> Void)) {
        loadFromDB { completion(.success($0))}
        loadFromNetwork(api: .stockExchange) { completion($0) }
    }
    
}
