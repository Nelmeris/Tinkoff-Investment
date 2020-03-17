//
//  DetailStockView.swift
//  DetailStockScreen_Example
//
//  Created by Artem Kufaev on 17.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

public struct DetailStockView: View {
    let companySymbol: String
    
    public init(with companySymbol: String) {
        self.companySymbol = companySymbol
    }
    
    public var body: some View {
        VStack {
            CompanyProfileView(with: self.companySymbol)
            CompanyNewsView(with: self.companySymbol)
        }.padding(.vertical)
            .navigationBarTitle(Text(self.companySymbol), displayMode: .inline)
    }
}

struct DetailStockView_Previews: PreviewProvider {
    static var previews: some View {
        DetailStockView(with: "AAPL")
    }
}
