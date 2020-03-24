//
//  AuthPinControllerDelegate.swift
//  AuthPinScreen
//
//  Created by Maria on 25.02.2020.
//

import Foundation

public protocol AuthPinControllerDelegate: class {
    func didPinCodeEntered(_ pin: String)
}
