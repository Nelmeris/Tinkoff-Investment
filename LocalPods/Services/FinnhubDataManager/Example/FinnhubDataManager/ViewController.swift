//
//  ViewController.swift
//  FinnhubDataManager
//
//  Created by Nelmeris on 03/15/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import FinnhubDataManager

class ViewController: UIViewController {

    var ticketDataManager: TicketDataManager!
    var newsDataManager: NewsDataManager!
    var exchangeDataManager: ExchangeDataManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        ticketDataManager = TicketDataManager()
        newsDataManager = NewsDataManager()
        exchangeDataManager = ExchangeDataManager()

        ticketDataManager.load(exchange: "US") { result in
            switch result {
            case .success(let tickets):
                guard let ticket = tickets.first else { return }
                print(ticket)
            case .failure(let error):
                print(error)
            }
        }
        newsDataManager.load { result in
            switch result {
            case .success(let news):
                guard let news = news.first else { return }
                print(news)
            case .failure(let error):
                print(error)
            }
        }
        exchangeDataManager.load { (result) in
            switch result {
            case .success(let exchanges):
                guard let exchange = exchanges.first else { return }
                print(exchange)
            case .failure(let error):
                print(error)
            }
        }
    }

}
