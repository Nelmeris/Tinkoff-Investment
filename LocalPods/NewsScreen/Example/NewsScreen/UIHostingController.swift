//
//  UIHostingController.swift
//  NewsScreen_Example
//
//  Created by Artem Kufaev on 15.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct ViewModel: Identifiable {
    let id: UUID = UUID()
    
    let image: UIImage
    let title: String
    let description: String
    let date: String
    let link: URL
}

struct UIHostingController: View {
    let viewModels: [ViewModel] = [
        ViewModel(image: UIImage(), title: "SomeTitle", description: "DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription", date: "10.10.2020", link: URL(string: "https://google.com/")!),
        ViewModel(image: UIImage(), title: "SomeTitle", description: "DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription", date: "10.10.2020", link: URL(string: "https://google.com/")!)
    ]
    
    var body: some View {
        ScrollView {
            ForEach(viewModels) { viewModel in
                KingfisherSwiftUI(viewModel: viewModel)
            }
            .padding(.horizontal, 20).padding(.vertical, 10)
            .shadow(color: .gray, radius: 2, x: 0, y: 3)
        }
        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
    }
}

struct KingfisherSwiftUI: View {
    let viewModel: ViewModel
    
    var body: some View {
        VStack {
            Image(uiImage: viewModel.image)
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.title).bold()
                Text(viewModel.description).lineLimit(6).foregroundColor(.gray)
                Spacer(minLength: 10)
                HStack {
                    Text(viewModel.date)
                    Spacer()
                    Button("Перейти в источник >") {
                        print(self.viewModel.link.absoluteURL)
                    }.foregroundColor(.blue)
                }
            }.padding(15)
        }.background(Color(white: 0.95))
            .cornerRadius(5)
    }
}

struct UIHostingController_Previews: PreviewProvider {
    static var previews: some View {
        UIHostingController()
    }
}
