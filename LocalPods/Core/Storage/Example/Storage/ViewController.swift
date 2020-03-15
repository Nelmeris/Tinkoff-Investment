//
//  ViewController.swift
//  Storage
//
//  Created by Nelmeris on 03/04/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import Storage
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storage = Storage<User>(modelName: "Test")
        
        let user1 = User(id: "0", username: "nelmeris", name: "Artem", birthday: Date())
        let user2 = User(id: "1", username: "nelmeris1", name: "Artem", birthday: Date())
        let user3 = User(id: "2", username: "nelmeris2", name: "Artem", birthday: Date())
        let user4 = User(id: "3", username: "nelmeris3", name: "Artem", birthday: Date())
        let user5 = User(id: "4", username: "nelmeris4", name: "Artem", birthday: Date())
        
        storage.write([user1, user2, user3, user4, user5])
        storage.readAll { print($0) }
        storage.read(id: "0") { print($0) }
        storage.delete(user3)
        storage.readAll { print($0) }
    }
    
    private func parseResult(_ result: Result<User, CoreDataWorkerError>) {
        switch result {
        case .success(let users):
            print(users)
        case .failure(let error):
            print("\(error)")
        }
    }

}

