//
//  ViewController.swift
//  FinnhubDataManager
//
//  Created by Nelmeris on 03/15/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import FinnhubDataManager
import Network

class ViewController: UIViewController {

    var ticketDataManager: TicketDataManager!
    var newsDataManager: NewsDataManager!
    var exchangeDataManager: ExchangeDataManager!
    var companyProfileDataManager: CompanyProfileDataManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        ticketDataManager = TicketDataManager()
        newsDataManager = NewsDataManager()
        exchangeDataManager = ExchangeDataManager()
        companyProfileDataManager = CompanyProfileDataManager()

        ticketDataManager.load(exchange: "US") { self.handleResult($0, with: "Tickets for US") }
        newsDataManager.load { self.handleResult($0, with: "News") }
        newsDataManager.load(with: "AAPL") { self.handleResult($0, with: "News for AAPL") }
        exchangeDataManager.load { self.handleResult($0, with: "Exchanges")}
        companyProfileDataManager.load(with: "AAPL") { self.handleResult($0, with: "AAPL profile") }
    }
    
    private func handleResult<T>(_ result: Result<T, NetworkError>, with name: String) {
        switch result {
        case .success:
            print("\(name) successed load")
        case .failure(let error):
            print("\(name) error: \(error.localizedDescription)")
        }
    }

}
