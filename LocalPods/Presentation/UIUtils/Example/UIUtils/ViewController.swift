//
//  ViewController.swift
//  UIUtils
//
//  Created by Nelmeris on 03/14/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import UIUtils

struct TextViewModel {
    let text: String
}

class Cell: UITableViewCell, ConfigurableCell {
    typealias ViewModel = TextViewModel
    
    func configure(_ viewModel: TextViewModel, at indexPath: IndexPath) {
        self.textLabel?.text = viewModel.text
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var adapter: TableViewAdapter<Cell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter = TableViewAdapter<Cell>(table: tableView)
        adapter.set(items: [
            TextViewModel(text: "1"),
            TextViewModel(text: "2"),
            TextViewModel(text: "3"),
            TextViewModel(text: "4"),
            TextViewModel(text: "5")
        ])
    }

}

