//
//  AuthScreensUITests.swift
//  Tinkoff Investor UI Tests
//
//  Created by Artem Kufaev on 18.03.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//

import XCTest
import AuthManager
import Keychain
import Nimble

class AuthScreensUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    func testAuth() {
        auth(isSetPin: false)
        waitSpinner()
        waitMainScreen()
    }
    
    func testPinViews() {
        auth(isSetPin: true)
        waitSpinner()
        XCTAssertFalse(app.tabBars.firstMatch.exists)
        expect(self.app.staticTexts["Введите PIN"].exists).toEventually(beTrue(), timeout: 5)
        typePin("2563")
        XCTAssertTrue(app.staticTexts["Повторите PIN"].exists)
    }
    
    func testPinMismatch() {
        auth(isSetPin: true)
        typePin("2563")
        typePin("3739")
        XCTAssertTrue(app.staticTexts["Несоответствие PIN кодов"].exists)
    }
    
    func testPinCorrect() {
        auth(isSetPin: true)
        typePin("7052")
        typePin("7052")
        waitMainScreen()
    }
    
    private func typePin(_ pin: String) {
        for symbol in pin {
            self.app.buttons[String(symbol)].tap()
        }
    }
    
    private func waitSpinner() {
        expect(self.app.activityIndicators.firstMatch.exists).toEventually(beTrue(), timeout: 5)
    }
    
    private func waitMainScreen() {
        expect(self.app.tabBars.firstMatch.exists).toEventually(beTrue(), timeout: 5)
    }
    
    private func auth(isSetPin: Bool) {
        app.textFields["LoginLabel"].tap()
        app.textFields["LoginLabel"].typeText("SomeLogin")
        
        app.keyboards.firstMatch.buttons["next"].tap()
        app.secureTextFields["PasswordLabel"].typeText("123456ABcd")
        
        app.staticTexts["TitleLabel"].tap()
        
        if isSetPin {
            app.buttons["SetPinLabel"].tap()
        }
        
        app.buttons["AuthButton"].tap()
    }
    
}
