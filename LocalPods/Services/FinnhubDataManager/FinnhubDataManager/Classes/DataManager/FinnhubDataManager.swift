//
//  FinnhubDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Network
import Storage

internal class FinnhubDataManager<Model: Decodable & ManagedObjectConvertible> {
    
    private var provider: Provider<FinnhubAPI>
    private var storage: Storage<Model>
    
    public init() {
        self.provider = Provider<FinnhubAPI>()
        let bundle = Bundle(for: Self.self)
        self.storage = Storage<Model>(modelName: "Finnhub", bundle: bundle)
    }
    
    public func load(api: FinnhubAPI, completion: @escaping (Result<[Model], Error>) -> Void) {
        loadFromDB { (data) in
            completion(.success(data))
        }
        loadFromNetwork(api: api) { result in
            switch result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    private func loadFromDB(completion: @escaping ([Model]) -> Void) {
        storage.readAll { (data) in
            completion(data)
        }
    }
    
    private func loadFromNetwork(api: FinnhubAPI, completion: @escaping (Result<[Model], NetworkError>) -> Void) {
        provider.load(api) { (result: NetworkResult<[Model]>) in
            switch result {
            case .success(let data):
                self.saveToDB(data)
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func saveToDB(_ data: [Model]) {
        storage.write(data)
    }
    
}
