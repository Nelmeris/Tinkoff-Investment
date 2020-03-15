//
//  NewsFeedCell.swift
//  NewsScreen_Example
//
//  Created by Artem Kufaev on 15.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

import struct Kingfisher.KFImage

struct NewsFeedCell: View {
    let viewModel: NewsViewModel
    @State var cellColor = Color(white: 0.95)
    
    var body: some View {
        VStack {
            KFImage(self.viewModel.imageURL)
                .cancelOnDisappear(true)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
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
                    Text(self.viewModel.date)
                    Spacer()
                    Button("Перейти в источник >") {
                        print(self.viewModel.url)
                    }.foregroundColor(.blue)
                }
            }.padding(15)
        }
        .background(self.cellColor)
        .cornerRadius(5)
        .padding(.horizontal, 20).padding(.vertical, 10)
        .shadow(color: .gray, radius: 2, x: 0, y: 3)
    }
}

struct NewsFeedCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedCell(viewModel:
            NewsViewModel(id: 25040,
                          imageURL: URL(string: "https://data.bloomberglp.com/company/sites/2/2019/01/logobbg-wht.png")!,
                          headline: "Facebook acknowledges flaw in Messenger Kids app",
                          summary: "Facebook Inc  acknowledged a flaw in its Messenger Kids app, weeks after two U.S. senators raised privacy concerns about the application, and said that it spoke to the U.S. Federal Trade Commission about the matter.",
                          date: DateFormatter.unix().string(from: Date(timeIntervalSince1970: 1567054115)),
                          url: "https://www.reuters.com/article/us-facebook-privacy/facebook-acknowledges-flaw-in-messenger-kids-app-idUSKCN1VJ08X")
        )
    }
}
