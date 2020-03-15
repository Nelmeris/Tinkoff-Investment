//
//  NewsCD+CoreDataProperties.swift
//  
//
//  Created by Artem Kufaev on 15.03.2020.
//
//

import Foundation
import CoreData

extension NewsCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsCD> {
        return NSFetchRequest<NewsCD>(entityName: "NewsCD")
    }

    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var url: String?
    @NSManaged public var headline: String?
    @NSManaged public var summary: String?
    @NSManaged public var datetime: Int64

}
