//
//  Ticket+CoreDataProperties.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//
//

import Foundation
import CoreData


extension TicketCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TicketCD> {
        return NSFetchRequest<TicketCD>(entityName: "TicketCD")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var displaySymbol: String?
    @NSManaged public var descript: String?

}
