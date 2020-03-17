//
//  ProfileViewModelFetcher.swift
//  DetailStockScreen_Example
//
//  Created by Artem Kufaev on 17.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import FinnhubDataManager

class ProfileViewModelFetcher: ObservableObject {
    @Published var viewModel: ProfileViewModel?
    @Published var error: Error?
    @Published var isError: Bool = false

    let dataManager: CompanyProfileDataManager
    let viewModelFactory: ProfileViewModelFactory
    
    let companySymbol: String

    init(with companySymbol: String) {
        dataManager = CompanyProfileDataManager()
        viewModelFactory = ProfileViewModelFactory()
        self.companySymbol = companySymbol
        load()
    }

    func load() {
        dataManager.load(with: self.companySymbol) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    guard let profile = profile else { return }
                    self.viewModel = self.viewModelFactory.make(from: profile)
                case .failure(let error):
                    self.error = error
                    self.isError = true
                }
            }
        }
    }
}
