//
//  NewsCD+CoreDataClass.swift
//  
//
//  Created by Artem Kufaev on 15.03.2020.
//
//

import Foundation
import CoreData
import Storage

@objc(NewsCD)
public class NewsCD: NSManagedObject {
    public class func getOrCreateSingle(with id: Int, from context: NSManagedObjectContext) -> NewsCD? {
        let entityName = String(describing: Self.self)
        let request = NSFetchRequest<NewsCD>(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %d", id)
        guard let result = try? context.fetch(request) else { return nil }
        return result.first ?? NewsCD(context: context)
    }
}

extension NewsCD: ManagedObjectProtocol {
    public typealias Entity = News

    public func toEntity() -> NewsCD.Entity? {
        let id = Int(self.id)
        let datetime = TimeInterval(integerLiteral: self.datetime)
        guard let image = self.image,
            let headline = self.headline,
            let summary = self.summary,
            let url = self.url else { return nil }
        return News(id: id,
                    image: image,
                    headline: headline,
                    summary: summary,
                    datetime: datetime,
                    url: URL(string: url)!)
    }
}
