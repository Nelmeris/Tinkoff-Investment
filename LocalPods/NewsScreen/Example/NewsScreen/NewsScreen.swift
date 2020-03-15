//
//  NewsScreen.swift
//  NewsScreen_Example
//
//  Created by Artem Kufaev on 15.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI
import Network
import Combine

public class ModelFetcher: ObservableObject {
    @Published var viewModels: [NewsViewModel] = []
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
                print(error)
            }
        }
    }
}

struct NewsScreen: View {
    @ObservedObject var fetcher = ModelFetcher()
    @State var backgroundColor = Color(red: 230/255, green: 230/255, blue: 230/255)
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(self.fetcher.viewModels) { viewModel in
                        NewsFeedCell(viewModel: viewModel)
                    }
                }.frame(width: geometry.size.width)
            }.background(self.backgroundColor)
        }
    }
}



struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}