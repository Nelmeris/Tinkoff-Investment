//
//  AuthPinScreenUITests.swift
//  AuthPinScreenUITests
//
//  Created by Artem Kufaev on 18.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import UIUtils

class AuthPinScreenUITests: FBSnapshotTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        // recordMode = true
        
        app = XCUIApplication()
        app.launch()
    }

    func testEmptyScreen() {
        takeScreenshot()
    }
    
    func testTwoNumbersClicledScreen() {
        app.buttons["1"].tap()
        app.buttons["1"].tap()
        takeScreenshot()
    }
    
    func testRepeatPinScreen() {
        for _ in 1...4 {
            app.buttons["1"].tap()
        }
        takeScreenshot()
    }
    
    func testIncorrectPinRepetitionScreen() {
        for _ in 1...4 {
            app.buttons["1"].tap()
        }
        for _ in 1...4 {
            app.buttons["2"].tap()
        }
        takeScreenshot()
    }
    
    private func takeScreenshot() {
        let screenshot = app.screenshot()
        let image = screenshot.image.removingStatusBar
        let imageView = UIImageView(image: image)
        FBSnapshotVerifyView(imageView)
    }
    
}
