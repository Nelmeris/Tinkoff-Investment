//
//  Exchange+CoreDataProperties.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//
//

import Foundation
import CoreData


extension Exchange {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exchange> {
        return NSFetchRequest<Exchange>(entityName: "Exchange")
    }

    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var currency: String?

}
