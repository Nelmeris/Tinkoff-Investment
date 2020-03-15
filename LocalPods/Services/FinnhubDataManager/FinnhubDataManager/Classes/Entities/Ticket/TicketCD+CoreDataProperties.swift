//
//  TicketCD+CoreDataProperties.swift
//  
//
//  Created by Artem Kufaev on 14.03.2020.
//
//

import Foundation
import CoreData

extension TicketCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TicketCD> {
        return NSFetchRequest<TicketCD>(entityName: "TicketCD")
    }

    @NSManaged public var descript: String?
    @NSManaged public var displaySymbol: String?
    @NSManaged public var symbol: String?

}
