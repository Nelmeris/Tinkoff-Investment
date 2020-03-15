//
//  ExchangeDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

public class ExchangeDataManager {
    private let baseDataManager: FinnhubDataManager<Exchange>

    public init() {
        self.baseDataManager = FinnhubDataManager()
    }

    public func load(completion: @escaping ((Result<[Exchange], Error>) -> Void)) {
        baseDataManager.load(api: .stockExchange) { (result) in
            completion(result)
        }
    }
}
