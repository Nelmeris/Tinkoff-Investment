//
//  ManagedObjectConvertible.swift
//  Pods-Storage_Example
//
//  Created by Artem Kufaev on 09.03.2020.
//

import CoreData

public protocol ManagedObjectProtocol: NSManagedObject {
    associatedtype Entity
    func toEntity() -> Entity?
}

public protocol ManagedObjectConvertible {
    associatedtype ManagedObject: ManagedObjectProtocol
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}
