//
//  User.swift
//  Storage_Example
//
//  Created by Artem Kufaev on 09.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import Storage
import CoreData

public struct User {
    let id:  String
    let username: String?
    var name:  String?
    var birthday:  Date?
}
 
extension User: ManagedObjectConvertible {
    public typealias ManagedObject = UserMO
    
    public func toManagedObject( in context:  NSManagedObjectContext)  ->  UserMO? {
        guard let user = UserMO.getOrCreateSingle(with: id, from: context)
            else { return nil }
 
        user.id = id
        user.username = username
        user.name = name
        user.birthday = birthday as Date?
        return user
    }
    
}
