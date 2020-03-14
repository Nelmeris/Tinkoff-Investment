//
//  AuthLoginViewController.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

import Validator
import DesignKit

public protocol AuthLoginViewControllerDelegate: class {
    func loginButtonDidClicked(login: String, password: String, isSetPin: Bool)
}

open class AuthLoginViewController: LoadingViewController {
    
    public weak var delegate: AuthLoginViewControllerDelegate?
    
    public var loginView: AuthLoginView {
        guard let view = self.view as? AuthLoginView else { fatalError() }
        return view
    }
    
    public override func loadView() {
        super.loadView()
        self.view = AuthLoginView()
        self.loginView.loginButton.addTarget(self, action: #selector(loginButtonDidClicked), for: .touchUpInside)
        self.loginView.loginField.delegate = self
        self.loginView.passwordField.delegate = self
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setHideKeyboardOnTap()
        configureUI()
    }
    
    private func configureUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    private func setHideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    private func loginButtonDidClicked() {
        let login = self.loginView.loginField.text ?? ""
        let password = self.loginView.passwordField.text ?? ""
        let isSetPin = self.loginView.isSetPinCheckbox.isChecked
        self.delegate?.loginButtonDidClicked(login: login, password: password, isSetPin: isSetPin)
    }
    
}

extension AuthLoginViewController: UITextFieldDelegate {
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        let login = self.loginView.loginField.text ?? ""
        let password = self.loginView.passwordField.text ?? ""
        loginView.loginButton.isEnabled =
            login.validate(rules: AuthLoginValidator.loginValidateRules).isValid &&
            password.validate(rules: AuthLoginValidator.passwordValidateRules).isValid
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = self.loginView.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
