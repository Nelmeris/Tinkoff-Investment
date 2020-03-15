//
//  News.swift
//
//  Created by Artem Kufaev on 15.03.2020.
//

import Foundation
import CoreData
import Storage

public struct News: Decodable {
    let id: Int
    let image: URL
    let headline: String
    let summary: String
    let datetime: TimeInterval
    let url: URL
}

extension News: ManagedObjectConvertible {
    public typealias ManagedObject = NewsCD

    public func toManagedObject(in context: NSManagedObjectContext) -> NewsCD? {
        guard let obj = NewsCD.getOrCreateSingle(with: self.id, from: context) else { return nil }
        obj.id = Int64(id)
        obj.image = image.absoluteString
        obj.datetime = Int64(datetime)
        obj.headline = headline
        obj.summary = summary
        obj.url = url.absoluteString
        return obj
    }
}
