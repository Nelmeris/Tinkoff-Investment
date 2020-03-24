//
//  NewsDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Network

public final class NewsDataManager: FinnhubDataManager<News> {
    
    public func load(completion: @escaping ((Result<[News], NetworkError>) -> Void)) {
        loadFromDB { completion(.success($0))}
        loadFromNetwork(api: .news) { completion($0) }
    }
    
    public func load(with companySymbol: String, completion: @escaping ((Result<[News], NetworkError>) -> Void)) {
        loadFromDB { result in
            let filtered = result.filter { $0.related == companySymbol }
            completion(.success(filtered))
        }
        loadFromNetwork(api: .companyNews(symbol: companySymbol)) { result in
            switch result {
            case .success(let news):
                let filtered = news.filter { $0.related == companySymbol }
                completion(.success(filtered))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
