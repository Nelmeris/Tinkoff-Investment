//
//  ModelFetcher.swift
//
//  Created by Artem Kufaev on 17.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import FinnhubDataManager
import NewsScreen

class NewsViewModelFetcher: ObservableObject {
    @Published var viewModels: [NewsViewModel] = []
    @Published var error: Error?
    @Published var isError: Bool = false

    let dataManager: NewsDataManager
    let viewModelFactory: NewsViewModelFactory
    
    let companySymbol: String

    init(with companySymbol: String) {
        dataManager = NewsDataManager()
        viewModelFactory = NewsViewModelFactory()
        self.companySymbol = companySymbol
        load()
    }

    func load() {
        dataManager.load(with: self.companySymbol) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    let viewModels = self.viewModelFactory.make(from: news)
                    self.viewModels = viewModels
                case .failure(let error):
                    self.error = error
                    self.isError = true
                }
            }
        }
    }
}
