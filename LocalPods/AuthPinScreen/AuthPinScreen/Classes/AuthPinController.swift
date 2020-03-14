//
//  AuthPinController.swift
//  AuthPinScreen
//
//  Created by Maria on 23.02.2020.
//

import UIKit
import DesignKit

public enum AuthPinState {
    case setPin // set new pin
    case confirmPin // sign in with pin
}

extension AuthPinController {
    public class func new() -> AuthPinController? {
        let bundle = Bundle(for: self)
        let controller = AuthPinController(nibName: "AuthPinController", bundle: bundle)
        return controller
    }
}

open class AuthPinController: LoadingViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pincodeView: PincodeView!
    
    @IBOutlet weak var errorLbl: UILabel?
    
    private var pincode: Pincode?
    private var confirmPincode: Pincode?
    private var activePincode: Pincode? {
        guard let pincode = pincode else { return nil }
        switch state {
        case .confirmPin:
            return pincode
        case .setPin:
            return pincode.isCodeFill() ? confirmPincode : pincode
        }
    }
    
    public var delegate: AuthPinControllerDelegate?
    public var state: AuthPinState = .setPin {
        didSet { if self.isViewLoaded { reset() } }
    }
    
    public var pincodeSize: Int = 4 {
        didSet { if self.isViewLoaded { configurePin() } }
    }
    
    // MARK: - Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        configurePin()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
    }
    
    // MARK: - Public
    
    public func sendError(_ msg: String) {
        catchError(msg: msg)
    }
    
    // MARK: - Private
    
    private func configurePin() {
        pincode = Pincode(with: pincodeSize)
        pincodeView.dotCount = pincodeSize
        pincode?.didFinishedEnterPin = { code in
            self.pinVerification()
        }
        if state == .setPin {
            pincode?.didFinishedEnterPin = { code in
                self.titleLabel.text = "Повторите PIN"
                self.pincodeView.emptyAllDots(animated: true)
            }
            confirmPincode = Pincode(with: pincodeSize)
            confirmPincode?.didFinishedEnterPin = { code in
                self.pinVerification()
            }
        }
    }
    
    private func reset() {
        titleLabel.text = "Введите PIN"
        pincode?.clear()
        confirmPincode?.clear()
        pincodeView.emptyAllDots(animated: true)
    }
    
    private func catchError(msg: String) {
        errorLbl?.text = msg
        errorLbl?.isHidden = false
        reset()
    }
    
    // MARK: - Actions
    
    @IBAction func touchNumberBtn(_ sender: UIButton) {
        errorLbl?.isHidden = true
        guard let char = String(sender.tag).first else { return }
        pincodeView.fillNextDot(animated: true)
        activePincode?.insert(char)
    }
    
    @IBAction func touchRemoveBtn(_ sender: Any) {
        errorLbl?.isHidden = true
        activePincode?.removeLast()
        pincodeView.emptyLastDot(animated: true)
    }
    
    private func pinVerification() {
        switch state {
        case .setPin:
            guard pincode?.code == confirmPincode?.code,
                let newPin = pincode?.code else {
                catchError(msg: "Несоответствие PIN кодов")
                return
            }
            delegate?.didPinCodeEntered(newPin)
        case .confirmPin:
            guard let code = pincode?.code else { return }
            delegate?.didPinCodeEntered(code)
        }
    }
    
}


