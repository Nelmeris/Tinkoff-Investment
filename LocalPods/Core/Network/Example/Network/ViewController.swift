//
//  ViewController.swift
//  Network
//
//  Created by Nelmeris on 03/10/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import Network

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = Provider<TicketAPI>()
        provider.load(.stockSymbol(exchange: "US")) { (result: NetworkResult<[Ticket]>) in
            switch result {
            case .success(let tickets):
                guard let ticket = tickets.first else { return }
                print(ticket)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
