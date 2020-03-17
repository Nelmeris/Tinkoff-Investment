//
//  DetailStockView.swift
//  DetailStockScreen_Example
//
//  Created by Artem Kufaev on 17.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import SwiftUI

struct DetailStockView: View {
    let companySymbol: String
    
    init(with companySymbol: String) {
        self.companySymbol = companySymbol
    }
    
    var body: some View {
        VStack {
            CompanyProfileView(with: self.companySymbol)
            CompanyNewsView(with: self.companySymbol)
        }.navigationBarTitle(self.companySymbol).padding(.vertical)
    }
}

struct DetailStockView_Previews: PreviewProvider {
    static var previews: some View {
        DetailStockView(with: "AAPL")
    }
}
