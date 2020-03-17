//
//  ViewController.swift
//  DetailStockScreen
//
//  Created by Nelmeris on 03/17/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import SwiftUI

import DetailStockScreen

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let companySymbol = "AAPL"
        let view = DetailStockView(with: companySymbol)
        let controller = UIHostingController(rootView: view)
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

