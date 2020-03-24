//
//  ViewController.swift
//  AuthManager
//
//  Created by mikhail on 02/19/2020.
//  Copyright (c) 2020 mikhail. All rights reserved.
//

import UIKit
import AuthManager
import Keychain

public class AuthViewController: UIViewController {

    private var auth: IAuthManager!

    override public func viewDidLoad() {
        super.viewDidLoad()
        let keychain = Keychain()
        self.auth = AuthManager(keychain: keychain)
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
            case .notLogin:
                print("not authorized")
            }
        }
    }

}
