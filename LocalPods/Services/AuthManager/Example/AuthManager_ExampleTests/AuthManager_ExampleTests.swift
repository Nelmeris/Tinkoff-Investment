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
    var keychain: IKeychain!
    
    override func setUp() {
        self.keychain = KeychainMock()
        self.auth = AuthManager(keychain: keychain)
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
        return stubbedLoadResult
    }
}
