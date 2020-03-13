//
//  Ticket+CoreDataProperties.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//
//

import Foundation
import CoreData


extension Ticket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ticket> {
        return NSFetchRequest<Ticket>(entityName: "Ticket")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var displaySymbol: String?
    @NSManaged public var descript: String?

}
