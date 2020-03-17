//
//  NewsDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Network

public class NewsDataManager {
    private let baseDataManager: FinnhubDataManager<News>

    public init() {
        self.baseDataManager = FinnhubDataManager()
    }

    public func load(completion: @escaping ((Result<[News], NetworkError>) -> Void)) {
        baseDataManager.load(api: .news) { (result) in
            completion(result)
        }
    }
    
    public func load(with companySymbol: String, completion: @escaping ((Result<[News], NetworkError>) -> Void)) {
        baseDataManager.load(api: .companyNews(symbol: companySymbol)) { (result: Result<[News], NetworkError>) in
            switch result {
            case .success(let data): completion(.success(data.filter { $0.related == companySymbol }))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
}
