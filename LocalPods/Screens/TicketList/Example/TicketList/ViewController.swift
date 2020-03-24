//
//  ViewController.swift
//  TicketList
//
//  Created by Nelmeris on 03/13/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import TicketList

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let controller = TicketListViewController.build()
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        navController.title = "Companies"
        self.present(navController, animated: true)
    }

}
