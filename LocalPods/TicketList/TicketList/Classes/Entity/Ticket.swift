//
//  Ticket.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//

import CoreData
import Storage

public struct Ticket: Decodable {
    let symbol: String
    let displaySymbol: String
    let description: String
}

extension Ticket: ManagedObjectConvertible {
    public typealias ManagedObject = TicketCD
    
    public func toManagedObject(in context: NSManagedObjectContext) -> Ticket.ManagedObject? {
        guard let obj = TicketCD.getOrCreateSingle(with: self.symbol, from: context) else { return nil }
        obj.symbol = self.symbol
        obj.displaySymbol = self.displaySymbol
        obj.descript = self.description
        return obj
    }
}
