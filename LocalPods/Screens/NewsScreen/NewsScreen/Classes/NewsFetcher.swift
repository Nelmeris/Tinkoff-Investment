//
//  NewsFetcher.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import SwiftUI
import Network

class ModelFetcher: ObservableObject {
    @Published var viewModels: [NewsViewModel] = []
    @Published var error: Error?
    @Published var isError: Bool = false

    let provider: Provider<FinnhubAPI>
    let viewModelFactory: NewsViewModelFactory

    init() {
        provider = Provider<FinnhubAPI>()
        viewModelFactory = NewsViewModelFactory()
        load()
    }

    func load() {
        provider.load(.news) { (result: NetworkResult<[News]>) in
            switch result {
            case .success(let viewModels):
                DispatchQueue.main.async {
                    self.viewModels = self.viewModelFactory.make(from: viewModels)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                    self.isError.toggle()
                }
            }
        }
    }
}
