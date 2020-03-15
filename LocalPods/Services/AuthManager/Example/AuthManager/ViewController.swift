//
//  ViewController.swift
//  AuthManager
//
//  Created by mikhail on 02/19/2020.
//  Copyright (c) 2020 mikhail. All rights reserved.
//

import UIKit
import AuthManager

public class AuthViewController: UIViewController {

    private var auth: AuthManager!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.auth = AuthManager()
        authentificate()
        auth.sendLoginCredentials(login: "Login", password: "Password")
        authentificate()
        auth.sendPin(code: "1234")
        authentificate()
    }
    
    private func authentificate() {
        auth.authentificate { (state) in
            switch state {
            case .credentials:
                print("credentials")
            case .confirmPin(let code):
                print(code)
            }
        }
    }

}

