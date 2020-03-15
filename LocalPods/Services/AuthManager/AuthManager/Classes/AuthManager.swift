//
//  AuthManager.swift
//  AuthManager
//
//  Created by Mikhail on 19.02.2020.
//

import Foundation

public class AuthManager {
    private enum KeychainKeys: String {
        case login, password, pin
    }
    
    public enum State {
        case credentials, confirmPin(code: String)
    }
    
    private let keychain = Keyсhain()
    
    public init() {}
    
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

private class Keyсhain {
    func save(key: String, string: String) -> OSStatus {
        let query: [String : Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrAccount as String: key,
                                     kSecValueData as String: Data(string.utf8)]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status
    }

    func remove(key: String) -> OSStatus {
        let query: [String : Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrAccount as String: key]
        return SecItemDelete(query as CFDictionary)
    }
    
    func load(key: String) -> String? {
        let query: [String : Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrAccount as String: key,
                                     kSecReturnData as String: kCFBooleanTrue!,
                                     kSecMatchLimit as String: kSecMatchLimitOne]
        var dataTypeRef: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
}
