//
//  NewsFeedCell.swift
//  NewsScreen_Example
//
//  Created by Artem Kufaev on 15.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct NewsFeedCell: View {
    let viewModel: NewsViewModel
    
    var body: some View {
        VStack {
            ImageView(withURL: self.viewModel.imageURL)
            VStack(alignment: .leading, spacing: 5) {
                Text(self.viewModel.headline).bold()
                Text(self.viewModel.summary).lineLimit(6).foregroundColor(.gray)
                Spacer(minLength: 10)
                HStack {
                    Text(self.viewModel.date)
                    Spacer()
                    Button("Перейти в источник >") {
                        print(self.viewModel.url)
                    }.foregroundColor(.blue)
                }
            }.padding(15)
        }
        .background(Color(white: 0.95))
        .cornerRadius(5)
    }
}

struct NewsFeedCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedCell(viewModel:
            NewsViewModel(id: 25040, imageURL:     "https://s2.reutersmedia.net/resources/r/?m=02&d=20200315&t=2&i=1503367707&w=1200&r=LYNXMPEG2E03H", headline: "Facebook acknowledges flaw in Messenger Kids app", summary: "Facebook Inc  acknowledged a flaw in its Messenger Kids app, weeks after two U.S. senators raised privacy concerns about the application, and said that it spoke to the U.S. Federal Trade Commission about the matter.", date: "1567054115", url: "https://www.reuters.com/article/us-facebook-privacy/facebook-acknowledges-flaw-in-messenger-kids-app-idUSKCN1VJ08X")
        )
    }
}
