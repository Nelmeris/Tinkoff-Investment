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

struct NewsScreen: View {
    @ObservedObject var fetcher = ModelFetcher()
    @State var backgroundColor = Color(red: 240/255, green: 240/255, blue: 240/255)
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(self.fetcher.viewModels) { viewModel in
                    NewsFeedCell(viewModel: viewModel)
                        .padding(.vertical, 5)
                }.padding(.horizontal, 20)
                .padding(.vertical, 15)
                .frame(width: geometry.size.width)
            }.background(self.backgroundColor)
        }.alert(isPresented: self.$fetcher.isError) { () -> Alert in
            Alert(title: Text("Ошибка"),
                  message: Text(self.fetcher.error?.localizedDescription ?? ""),
                  dismissButton: .cancel())
        }
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
