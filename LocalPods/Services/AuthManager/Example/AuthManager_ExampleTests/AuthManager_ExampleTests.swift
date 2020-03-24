//
//  AuthManager_ExampleTests.swift
//  AuthManager_ExampleTests
//
//  Created by Artem Kufaev on 18.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import AuthManager
import Keychain

class AuthManagerTests: XCTestCase {

    var auth: IAuthManager!
    var keychain: KeychainMock!

    let credentials = (login: "Login",
                       password: "Password",
                       pin: "PIN")
    
    override func setUp() {
        self.keychain = KeychainMock()
        self.auth = AuthManager(keychain: keychain)
    }
    
    // Проверка авторизации без пина
    func testAuth() {
        // Given
        keychain.stubbedSaveResult = .max
        keychain.stubbedLoadResult = credentials.login
        
        // When
        auth.sendLoginCredentials(login: credentials.login, password: credentials.password)
        
        // Then
        auth.authentificate { (state) in
            switch state {
            case .credentials:
                XCTAssert(true)
            case .notLogin:
                XCTFail("Авторизация не прошла")
            case .confirmPin:
                XCTFail("Внезапный PIN")
            }
        }
    }
    
    // Проверка авторизации с пином
    func testAuthWithPin() {
        // Given
        keychain.stubbedSaveResult = .max
        keychain.stubbedLoadResult = credentials.login
        
        // When
        auth.sendLoginCredentials(login: credentials.login, password: credentials.password)
        auth.sendPin(code: credentials.2)
        
        // Then
        auth.authentificate { (state) in
            switch state {
            case .credentials:
                XCTFail("PIN не установился")
            case .notLogin:
                XCTFail("Авторизация не прошла")
            case .confirmPin:
                XCTAssert(true)
            }
        }
    }
    
    // Проверка деавторизации после логина
    func testResetAuthAfterLogin() {
        // Given
        keychain.stubbedSaveResult = .max
        keychain.stubbedLoadResult = credentials.login
        keychain.stubbedRemoveResult = .max
        
        // When
        auth.sendLoginCredentials(login: credentials.login, password: credentials.password)
        auth.resetCredentials()
        
        // Then
        auth.authentificate { (state) in
            switch state {
            case .credentials:
                XCTFail("Авторизация не сбросилась")
            case .notLogin:
                XCTAssert(true)
            case .confirmPin:
                XCTFail("Авторизация не сбросилась и внезапный PIN")
            }
        }
    }
    
    // Проверка деавторизации после логина с пином
    func testResetAuthAfterLoginAndPin() {
        // Given
        keychain.stubbedSaveResult = .max
        keychain.stubbedLoadResult = credentials.login
        keychain.stubbedRemoveResult = .max
        
        // When
        auth.sendLoginCredentials(login: credentials.login, password: credentials.password)
        auth.sendPin(code: credentials.pin)
        auth.resetCredentials()
        
        // Then
        auth.authentificate { (state) in
            switch state {
            case .credentials:
                XCTFail("Авторизация не сбросилась, PIN либо не установился, либо сбросился только он")
            case .notLogin:
                XCTAssert(true)
            case .confirmPin:
                XCTFail("Авторизация не сбросилась")
            }
        }
    }

}

class KeychainMock: IKeychain {
    var invokedSave = false
    var invokedSaveCount = 0
    var invokedSaveParameters: (key: String, string: String)?
    var invokedSaveParametersList = [(key: String, string: String)]()
    var stubbedSaveResult: OSStatus!
    func save(key: String, string: String) -> OSStatus {
        invokedSave = true
        invokedSaveCount += 1
        invokedSaveParameters = (key, string)
        invokedSaveParametersList.append((key, string))
        return stubbedSaveResult
    }
    var invokedRemove = false
    var invokedRemoveCount = 0
    var invokedRemoveParameters: (key: String, Void)?
    var invokedRemoveParametersList = [(key: String, Void)]()
    var stubbedRemoveResult: OSStatus!
    func remove(key: String) -> OSStatus {
        invokedRemove = true
        invokedRemoveCount += 1
        invokedRemoveParameters = (key, ())
        invokedRemoveParametersList.append((key, ()))
        invokedSaveParametersList.removeAll { $0.key == key }
        return stubbedRemoveResult
    }
    var invokedLoad = false
    var invokedLoadCount = 0
    var invokedLoadParameters: (key: String, Void)?
    var invokedLoadParametersList = [(key: String, Void)]()
    var stubbedLoadResult: String!
    func load(key: String) -> String? {
        invokedLoad = true
        invokedLoadCount += 1
        invokedLoadParameters = (key, ())
        invokedLoadParametersList.append((key, ()))
        return (invokedSaveParametersList.first(where: { $0.key == key }) != nil) ? stubbedLoadResult : nil
    }
}
