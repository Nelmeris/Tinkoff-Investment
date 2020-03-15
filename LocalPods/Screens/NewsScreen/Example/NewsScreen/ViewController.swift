//
//  ViewController.swift
//  NewsScreen
//
//  Created by Nelmeris on 03/15/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import SwiftUI
import NewsScreen

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let swiftUIView = NewsFeedView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.modalPresentationStyle = .fullScreen
        present(hostingController, animated: true)
    }

}
