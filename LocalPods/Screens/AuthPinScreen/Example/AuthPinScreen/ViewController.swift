//
//  ViewController.swift
//  AuthPinScreen
//
//  Created by mikhail on 02/19/2020.
//  Copyright (c) 2020 mikhail. All rights reserved.
//

import UIKit
import AuthPinScreen

class ViewController: UIViewController, AuthPinControllerDelegate {

    let testPin = "1111"
    weak var controller: AuthPinController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthPinController()
    }
    
    func setupAuthPinController() {
        guard let controller = AuthPinController.new() else { return }
        controller.delegate = self
        self.controller = controller
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didPinCodeEntered(_ pin: String) {
        print("Entered PIN: \(pin)")
        controller?.showSpinner()
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            self.controller?.hideSpinner()
            if self.testPin != pin {
                self.controller?.sendError("Пин не верен!")
            } else {
                self.controller?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

