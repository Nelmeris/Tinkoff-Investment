//
//  AuthManager.swift
//  AuthManager
//
//  Created by Mikhail on 19.02.2020.
//

import Foundation
import Keychain

public protocol IAuthManager {
    func authentificate(_ completion: (_ state: AuthManager.State) -> Void)
    func sendLoginCredentials(login: String, password: String)
    func sendPin(code: String)
    func resetCredentials()
}

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
    
}

extension AuthManager: IAuthManager {

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
