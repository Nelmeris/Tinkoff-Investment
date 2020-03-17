//
//  NewsFeedCellView.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import SwiftUI
import DesignKit

import struct Kingfisher.KFImage

public struct NewsFeedCellView: View {
    let viewModel: NewsViewModel
    @State var cellColor = Color.white
    @State var showSafari = false
    @State var isImageLoaded = false
    
    public init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            KFImage(self.viewModel.imageURL).onSuccess { (_) in
                self.isImageLoaded = true
            }
                .cancelOnDisappear(true)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, minHeight: 0, maxHeight: !isImageLoaded ? 0 : nil)
                .layoutPriority(3)
            VStack(alignment: .leading, spacing: 5) {
                Text(self.viewModel.headline)
                    .bold()
                    .layoutPriority(2)
                Text(self.viewModel.summary)
                    .foregroundColor(.gray)
                    .lineLimit(6)
                    .layoutPriority(1)
                HStack {
                    Text(self.viewModel.date).font(Font.system(size: 13))
                    Spacer()
                    Button("Источник") {
                        self.showSafari = true
                    }.sheet(isPresented: self.$showSafari) {
                        SafariView(url: self.viewModel.url)
                    }.foregroundColor(.blue)

                }.padding(.top, 5)
            }.padding(20)
        }
        .background(self.cellColor)
        .cornerRadius(5)
        .shadow(color: .gray, radius: 2, x: 0, y: 3)
    }
}

struct NewsFeedCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedCellView(viewModel:
            NewsViewModel(id: 25040,
                          imageURL: URL(string: "https://data.bloomberglp.com/company/sites/2/2019/01/logobbg-wht.png")!,
                          headline: "Facebook acknowledges flaw in Messenger Kids app",
                          summary: "Facebook Inc  acknowledged a flaw in its Messenger Kids app, weeks after two U.S. senators raised privacy concerns about the application, and said that it spoke to the U.S. Federal Trade Commission about the matter.",
                          date: DateFormatter.unix().string(from: Date(timeIntervalSince1970: 1567054115)),
                          url: URL(string: "https://www.reuters.com/article/us-facebook-privacy/facebook-acknowledges-flaw-in-messenger-kids-app-idUSKCN1VJ08X")!)
        )
    }
}
