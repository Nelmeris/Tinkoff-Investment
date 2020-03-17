//
//  CompanyProfileCD+CoreDataProperties.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 17.03.2020.
//
//

import Foundation
import CoreData


extension CompanyProfileCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyProfileCD> {
        return NSFetchRequest<CompanyProfileCD>(entityName: "CompanyProfileCD")
    }

    @NSManaged public var currency: String?
    @NSManaged public var name: String?
    @NSManaged public var ticker: String?
    @NSManaged public var descript: String?

}
