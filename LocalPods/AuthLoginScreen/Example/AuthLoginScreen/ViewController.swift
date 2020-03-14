//
//  ViewController.swift
//  AuthLoginScreen
//
//  Created by mikhail on 02/19/2020.
//  Copyright (c) 2020 mikhail. All rights reserved.
//

import UIKit
import AuthLoginScreen

class ViewController: AuthLoginViewController, AuthLoginViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.delegate = self
    }
    
    func loginButtonDidClicked(login: String, password: String, isSetPin: Bool) {
        self.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.hideSpinner()
            print((login, password, isSetPin))
        }
    }

}

