//
//  CompanyProfileDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 17.03.2020.
//

import Network

public final class CompanyProfileDataManager: FinnhubDataManager<CompanyProfile> {
    
    public func load(with symbol: String, completion: @escaping ((Result<CompanyProfile?, NetworkError>) -> Void)) {
        loadFromDB { (result) in
            completion(.success(result.first { $0.ticker == symbol }))
        }
        loadFromNetworkSingle(api: .companyProfile(symbol: symbol)) { (result) in
            switch result {
            case .success(let profile):
                completion(.success(profile) )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
