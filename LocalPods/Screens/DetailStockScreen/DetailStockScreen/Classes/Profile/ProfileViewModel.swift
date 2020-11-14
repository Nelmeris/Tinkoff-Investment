//
//  ProfileViewModel.swift
//  DetailStockScreen_Example
//
//  Created by Artem Kufaev on 17.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import FinnhubDataManager

struct ProfileViewModel {
    public let ticker: String
    public let name: String
    public let currency: String
    public let description: String
    public var shortDescription: String { String(description.prefix(180)) }
}

class ProfileViewModelFactory {
    
    public func make(from models: [CompanyProfile]) -> [ProfileViewModel] {
        return models.map(make)
    }
    
    public func make(from model: CompanyProfile) -> ProfileViewModel {
        let ticker = model.ticker
        let name = model.name
        let currency = model.currency
        let description = model.description
        return ProfileViewModel(ticker: ticker ?? "",
                                name: name ?? "",
                                currency: currency ?? "",
                                description: description ?? "")
    }
    
}
