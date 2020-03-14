//
//  UIViewController+Spinner.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 03.03.2020.
//

import Foundation

public protocol Loading {
    var spinnerView: SpinnerView { get }
    var spinnerViewConstraints: [NSLayoutConstraint] { get }
    func showSpinner()
    func hideSpinner()
}

extension Loading where Self: UIViewController {
    
    public func showSpinner() {
        spinnerView.indicatorView.startAnimating()
        self.view.isUserInteractionEnabled = false
        self.view.addSubview(spinnerView)
        NSLayoutConstraint.activate(spinnerViewConstraints)
    }
    
    public func hideSpinner() {
        spinnerView.indicatorView.stopAnimating()
        view.isUserInteractionEnabled = true
        NSLayoutConstraint.deactivate(spinnerViewConstraints)
        spinnerView.removeFromSuperview()
    }
    
}
