//
//  FinnhubDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Network
import Storage

public class FinnhubDataManager<Model: Decodable & ManagedObjectConvertible> {

    private var provider: Provider<FinnhubAPI>
    private var storage: Storage<Model>

    public init() {
        self.provider = Provider<FinnhubAPI>()
        let bundle = Bundle(for: Self.self)
        self.storage = Storage<Model>(modelName: "Finnhub", bundle: bundle)
    }

    internal func loadFromDB(completion: @escaping ([Model]) -> Void) {
        storage.readAll { (data) in
            completion(data)
        }
    }

    internal func loadFromNetworkSingle(api: FinnhubAPI, completion: @escaping (Result<Model, NetworkError>) -> Void) {
        provider.load(api) { (result: NetworkResult<Model>) in
            switch result {
            case .success(let data):
                self.saveToDB([data])
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    internal func loadFromNetwork(api: FinnhubAPI, completion: @escaping (Result<[Model], NetworkError>) -> Void) {
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
