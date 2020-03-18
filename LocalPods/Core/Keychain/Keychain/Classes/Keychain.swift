//
//  Keychain.swift
//  Keychain
//
//  Created by Artem Kufaev on 18.03.2020.
//

import Foundation

public protocol IKeychain {
    func save(key: String, string: String) -> OSStatus
    func remove(key: String) -> OSStatus
    func load(key: String) -> String?
}

public class Keychain: IKeychain {
    public init() {}
    
    public func save(key: String, string: String) -> OSStatus {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrAccount as String: key,
                                     kSecValueData as String: Data(string.utf8)]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status
    }

    public func remove(key: String) -> OSStatus {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrAccount as String: key]
        return SecItemDelete(query as CFDictionary)
    }

    public func load(key: String) -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                     kSecAttrAccount as String: key,
                                     kSecReturnData as String: kCFBooleanTrue!,
                                     kSecMatchLimit as String: kSecMatchLimitOne]
        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
}
