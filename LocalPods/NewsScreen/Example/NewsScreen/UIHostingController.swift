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
        ViewModel(image: UIImage(), title: "SomeTitle", description: "DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription", date: "10.10.2020", link: URL(string: "https://google.com/")!),
        ViewModel(image: UIImage(), title: "SomeTitle", description: "DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription", date: "10.10.2020", link: URL(string: "https://google.com/")!),
        ViewModel(image: UIImage(), title: "SomeTitle", description: "DescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescriptionDescription", date: "10.10.2020", link: URL(string: "https://google.com/")!)
    ]
    
    var body: some View {
        List(viewModels) { viewModel in
            Rectangle().fill(Color.black).frame(width: 2)
            Spacer(minLength: 15)
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.title).bold()
                Text(viewModel.description).lineLimit(6)
                Spacer(minLength: 10)
                HStack {
                    Text(viewModel.date)
                    Spacer()
                    Button("Перейти в источник >") {
                        print(viewModel.link.absoluteURL)
                    }.foregroundColor(.blue)
                }
            }
        }
    }
}

struct UIHostingController_Previews: PreviewProvider {
    static var previews: some View {
        UIHostingController()
    }
}
