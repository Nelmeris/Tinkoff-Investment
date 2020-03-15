//
//  NewsDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

public class NewsDataManager {
    private let baseDataManager: FinnhubDataManager<News>
    
    public init() {
        self.baseDataManager = FinnhubDataManager()
    }
    
    public func load(completion: @escaping ((Result<[News], Error>) -> Void)) {
        baseDataManager.load(api: .news) { (result) in
            completion(result)
        }
    }
}
