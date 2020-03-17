//
//  CompanyNewsView.swift
//  DetailStockScreen_Example
//
//  Created by Artem Kufaev on 17.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import NewsScreen

struct CompanyNewsView: View {
    @ObservedObject var fetcher: NewsViewModelFetcher
    
    init(with companySymbol: String) {
        self.fetcher = NewsViewModelFetcher(with: companySymbol)
    }
    
    var body: some View {
        List {
            Section(header: Text("News")) {
                ForEach(self.fetcher.viewModels) { viewModel in
                    NewsFeedCellView(viewModel: viewModel)
                }
            }
        }
    }
}

struct CompanyNewsView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyNewsView(with: "AAPL")
    }
}
