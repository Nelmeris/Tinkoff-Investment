//
//  Exchange.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//

import CoreData
import Storage

public struct Exchange: Decodable {
    let name: String
    let code: String
    let currency: String
}

extension Exchange: ManagedObjectConvertible {
    public typealias ManagedObject = ExchangeCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> ExchangeCD? {
        guard let obj = ExchangeCD.getOrCreateSingle(with: self.code, from: context) else { return nil }
        obj.code = self.code
        obj.currency = self.currency
        obj.name = self.name
        return obj
    }
}
