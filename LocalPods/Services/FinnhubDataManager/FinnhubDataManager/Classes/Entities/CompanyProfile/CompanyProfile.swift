//
//  CompanyProfile.swift
//
//  Created by Artem Kufaev on 17.03.2020.
//

import Foundation
import CoreData
import Storage

public struct CompanyProfile: Decodable {
    public let ticker: String
    public let name: String
    public let currency: String
    public let description: String
}

extension CompanyProfile: ManagedObjectConvertible {
    public typealias ManagedObject = CompanyProfileCD

    public func toManagedObject(in context: NSManagedObjectContext) -> CompanyProfileCD? {
        guard let obj = CompanyProfileCD.getOrCreateSingle(with: self.ticker, from: context) else { return nil }
        obj.ticker = ticker
        obj.name = name
        obj.currency = currency
        obj.descript = description
        return obj
    }
}
