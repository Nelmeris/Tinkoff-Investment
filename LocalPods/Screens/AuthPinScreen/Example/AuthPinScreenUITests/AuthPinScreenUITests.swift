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

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        recordMode = true
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let screenshot = app.screenshot()
        FBSnapshotVerifyView(UIImageView(image: screenshot.image.removingStatusBar))
    }
    
}
