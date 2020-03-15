//
//  UserMO+CoreDataClass.swift
//  
//
//  Created by Artem Kufaev on 09.03.2020.
//
//

import Foundation
import CoreData
import Storage

@objc(UserMO)
public class UserMO: NSManagedObject {
    class func getOrCreateSingle(with id: String, from context: NSManagedObjectContext) -> UserMO? {
        let entityName = String(describing: Self.self)
        let request = NSFetchRequest<UserMO>(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %@", id)
        guard let result = try? context.fetch(request) else { return nil }
        return result.first ?? UserMO(context: context)
    }
}
 
extension UserMO: ManagedObjectProtocol {
    public func toEntity() -> User? {
        return User(id: id!,
                     username:username,
                    name:  name,
                    birthday:  birthday as Date?)
    }
}
