//
//  UserMO+CoreDataProperties.swift
//  
//
//  Created by Artem Kufaev on 09.03.2020.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "UserMO")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var birthday: Date?

}
