//
//  ContentController.swift
//  Tinkoff Investment
//
//  Created by Mikhail on 19.02.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//

import UIKit
import AuthManager
import AuthPinScreen

class ContentController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpLogout(_ sender: Any) {
        guard let root = navigationController as? RootAppController else { return }
        root.dismissContent()
    }
}
