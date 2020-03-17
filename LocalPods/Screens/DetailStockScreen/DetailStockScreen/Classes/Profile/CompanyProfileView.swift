//
//  CompanyProfileView.swift
//  DetailStockScreen_Example
//
//  Created by Artem Kufaev on 17.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct CompanyProfileView: View {
    let companySymbol: String
    
    @State var isDetail: Bool = false
    @ObservedObject var viewModelFetcher: ProfileViewModelFetcher
    
    init(with companySymbol: String) {
        self.companySymbol = companySymbol
        self.viewModelFetcher = ProfileViewModelFetcher(with: companySymbol)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.purple, .pink]),
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                    Text(viewModelFetcher.viewModel?.ticker ?? "")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                }.frame(width: 50, height: 50)
                Text(viewModelFetcher.viewModel?.name ?? "")
                    .font(Font.system(size: 23))
                Spacer()
                Text(viewModelFetcher.viewModel?.currency ?? "")
                    .font(.system(size: 14))
            }
            Text((isDetail ?
                viewModelFetcher.viewModel?.description :
                viewModelFetcher.viewModel?.shortDescription) ?? "")
                .font(.system(size: 14))
            Button(action: {
                withAnimation(.linear(duration: 0.3)) {
                    self.isDetail.toggle()
                }
            }) {
                Spacer()
                Text(isDetail ? "Скрыть" : "Отобразить").font(.system(size: 15))
                Spacer()
            }
        }.padding(.horizontal, 25)
    }
    
}

struct CompanyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyProfileView(with: "AAPL")
    }
}
