//
//  NewsFeedView.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import SwiftUI
import Network
import Combine

public struct NewsFeedView: View {
    @ObservedObject var fetcher = ModelFetcher()
    @State var backgroundColor = Color(red: 240/255, green: 240/255, blue: 240/255)

    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ForEach(self.fetcher.viewModels) { viewModel in
                    NewsFeedCellView(viewModel: viewModel)
                        .padding(.vertical, 5)
                }.padding(.horizontal, 20)
                .padding(.vertical, 15)
                .frame(width: geometry.size.width)
            }.background(self.backgroundColor)
        }
        .alert(isPresented: $fetcher.isError, content: {
            Alert(title: Text("Error"),
                  message: Text(fetcher.error?.localizedDescription ?? "Unknown error"),
                  dismissButton: .default(Text("Ok 😔")))
        })
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
