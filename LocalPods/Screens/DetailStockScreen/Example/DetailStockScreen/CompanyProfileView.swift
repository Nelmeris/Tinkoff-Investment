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
    
    init(with companySymbol: String) {
        self.companySymbol = companySymbol
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                ZStack {
                    
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .top, endPoint: .bottom))
                    Text("AAPL").font(.system(size: 16)).foregroundColor(.white)
                }.frame(width: 50, height: 50)
                Text("Apple Inc").font(Font.system(size: 23))
                Spacer()
                Text("USD").font(.system(size: 14))
            }
            Text(isDetail ? description : shortDescription).font(.system(size: 14))
            Button(action: {
                self.isDetail.toggle()
            }) {
                Spacer()
                Text(isDetail ? "Скрыть" : "Отобразить").font(.system(size: 15))
                Spacer()
            }
        }.padding(.horizontal, 25)
    }
    
    private var description: String = "LoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsgwgwegwgwegwegwgwgumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsumLoremImsgwgwegwgwegwegwgwgum"
    
    private var shortDescription: String {
        return String(description.prefix(180))
    }
    
}

struct CompanyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyProfileView(with: "AAPL")
    }
}
