//
//  CompanyProfileDataManager.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 17.03.2020.
//

public class CompanyProfileDataManager {
    private let baseDataManager: FinnhubDataManager<CompanyProfile>

    public init() {
        self.baseDataManager = FinnhubDataManager()
    }

    public func load(with symbol: String, completion: @escaping ((Result<[CompanyProfile], Error>) -> Void)) {
        baseDataManager.load(api: .companyProfile(symbol: symbol)) { (result) in
            completion(result)
        }
    }
    
}
