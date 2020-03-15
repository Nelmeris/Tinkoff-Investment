//
//  LoadingViewController.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 03.03.2020.
//

open class LoadingViewController: UIViewController, Loading {
    
    public private(set) lazy var spinnerView: SpinnerView = {
        let view = SpinnerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    public lazy var spinnerViewConstraints: [NSLayoutConstraint] = {
        let safeArea = self.view.safeAreaLayoutGuide
        return [
            spinnerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            spinnerView.heightAnchor.constraint(equalToConstant: 100),
            spinnerView.widthAnchor.constraint(equalToConstant: 100)
        ]
    }()
    
}
