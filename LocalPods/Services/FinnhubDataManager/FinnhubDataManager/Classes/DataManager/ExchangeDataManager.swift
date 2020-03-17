//
//  ExchangeDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Network

public class ExchangeDataManager {
    private let baseDataManager: FinnhubDataManager<Exchange>

    public init() {
        self.baseDataManager = FinnhubDataManager()
    }

    public func load(completion: @escaping ((Result<[Exchange], NetworkError>) -> Void)) {
        baseDataManager.load(api: .stockExchange) { (result) in
            completion(result)
        }
    }
}
