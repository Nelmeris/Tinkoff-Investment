//
//  AuthManager.swift
//  AuthManager
//
//  Created by Mikhail on 19.02.2020.
//

import Foundation
import Keychain

public class AuthManager {
    private enum KeychainKeys: String {
        case login, password, pin
    }

    public enum State {
        case credentials, confirmPin(code: String)
    }

    private let keychain: IKeychain

    public init(keychain: IKeychain) {
        self.keychain = keychain
    }

    public func authentificate(_ completion: (_ state: State) -> Void) {
        if let pin = keychain.load(key: KeychainKeys.pin.rawValue) {
            completion(.confirmPin(code: pin))
        } else {
            completion(.credentials)
        }
    }

    public func sendLoginCredentials(login: String, password: String) {
        _ = keychain.save(key: KeychainKeys.login.rawValue, string: login)
        _ = keychain.save(key: KeychainKeys.password.rawValue, string: password)
    }

    public func sendPin(code: String) {
        _ = keychain.save(key: KeychainKeys.pin.rawValue, string: code)
    }

    public func resetCredentials() {
        _ = keychain.remove(key: KeychainKeys.login.rawValue)
        _ = keychain.remove(key: KeychainKeys.password.rawValue)
        _ = keychain.remove(key: KeychainKeys.pin.rawValue)
    }
}
