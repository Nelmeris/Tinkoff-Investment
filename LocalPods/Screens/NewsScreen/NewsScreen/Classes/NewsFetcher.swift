//
//  NewsFetcher.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import SwiftUI
import FinnhubDataManager

class ModelFetcher: ObservableObject {
    @Published var viewModels: [NewsViewModel] = []
    @Published var error: Error?
    @Published var isError: Bool = false

    let dataManager: NewsDataManager
    let viewModelFactory: NewsViewModelFactory

    init() {
        dataManager = NewsDataManager()
        viewModelFactory = NewsViewModelFactory()
        load()
    }

    func load() {
        dataManager.load { (result) in
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
