//
//  ExchangeCD+CoreDataProperties.swift
//  
//
//  Created by Artem Kufaev on 14.03.2020.
//
//

import Foundation
import CoreData


extension ExchangeCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeCD> {
        return NSFetchRequest<ExchangeCD>(entityName: "ExchangeCD")
    }

    @NSManaged public var code: String?
    @NSManaged public var currency: String?
    @NSManaged public var name: String?

}
