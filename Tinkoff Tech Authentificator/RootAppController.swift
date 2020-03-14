//
//  RootAppController.swift
//  Tinkoff Tech Authentificator
//
//  Created by Mikhail on 20.02.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//

import UIKit
import AuthManager
import AuthLoginScreen
import AuthPinScreen

private typealias Credentials = (login: String, password: String)

class RootAppController: UINavigationController {
    private lazy var auth = AuthManager()
    private var pinCode: String?
    private var authPin: AuthPinController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAuthState()
    }
    
    private func checkAuthState() {
        auth.authentificate { [weak self] state in
            switch state {
            case .credentials:
                self?.runLogin()
            case .confirmPin(let code):
                self?.pinCode = code
                self?.runConfirmPin()
            }
        }
    }
    
    private func runLogin() {
        let login = AuthLoginViewController()
        login.delegate = self
        setViewControllers([login], animated: true)
    }
    
    private func runConfirmPin() {
        guard let pin = AuthPinController.new() else { fatalError() }
        self.authPin = pin
        pin.delegate = self
        pin.state = .confirmPin
        setViewControllers([pin], animated: true)
    }
    
    private func runSetPinIfNeeded(_ needPin: Bool) {
        guard let authPin = AuthPinController.new() else { fatalError() }
        self.authPin = authPin
        guard needPin else {
            runContent()
            return
        }
        authPin.delegate = self
        authPin.state = .setPin
        setViewControllers([authPin], animated: false)
    }

    private func runContent() {
        guard let content = R.storyboard.main.contentController() else { return }
        setViewControllers([content], animated: true)
    }
    
    private func sendCredentials(_ credentials: Credentials) {
        auth.sendLoginCredentials(login: credentials.login, password: credentials.password)
    }
    
    private func sendNewPin(_ code: String) {
        auth.sendPin(code: code)
    }
        
    func dismissContent() {
        auth.resetCredentials()
        runLogin()
    }
}

// MARK: AuthLoginViewControllerDelegate
extension RootAppController: AuthLoginViewControllerDelegate {
    func loginButtonDidClicked(login: String, password: String, isSetPin: Bool) {
        sendCredentials((login, password))
        guard let login = viewControllers.first as? AuthLoginViewController else { return }
        login.showSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) { [weak self] in
            login.hideSpinner()
            self?.runSetPinIfNeeded(isSetPin)
        }
    }
}

extension RootAppController: AuthPinControllerDelegate {
    func didPinCodeEntered(_ pin: String) {
        authPin?.showSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            self?.authPin?.hideSpinner()
            if let pinCode = self?.pinCode {
                guard pinCode == pin else {
                    self?.authPin?.sendError("Неверный PIN")
                    return
                }
            } else {
                self?.sendNewPin(pin)
            }
            self?.runContent()
        }
    }
}
