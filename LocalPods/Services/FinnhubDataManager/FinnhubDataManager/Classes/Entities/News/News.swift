//
//  News.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Foundation
import CoreData
import Storage

public struct News: Decodable {
    public let id: Int
    public let image: String
    public let headline: String
    public let summary: String
    public let datetime: TimeInterval
    public let related: String
    public let url: URL
    
    public init(id: Int,
                image: String,
                headline: String,
                summary: String,
                datetime: TimeInterval,
                related: String,
                url: URL) {
        self.id = id
        self.image = image
        self.headline = headline
        self.summary = summary
        self.datetime = datetime
        self.related = related
        self.url = url
    }
}

extension News: ManagedObjectConvertible {
    public typealias ManagedObject = NewsCD

    public func toManagedObject(in context: NSManagedObjectContext) -> NewsCD? {
        guard let obj = NewsCD.getOrCreateSingle(with: self.id, from: context) else { return nil }
        obj.id = Int64(id)
        obj.image = image
        obj.datetime = Int64(datetime)
        obj.headline = headline
        obj.related = related
        obj.summary = summary
        obj.url = url.absoluteString
        return obj
    }
}
