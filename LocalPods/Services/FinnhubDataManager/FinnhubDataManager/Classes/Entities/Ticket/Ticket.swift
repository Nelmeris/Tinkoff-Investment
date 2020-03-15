//
//  Ticket.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//

import CoreData
import Storage

public struct Ticket: Decodable {
    public let symbol: String
    public let displaySymbol: String
    public let description: String
}

extension Ticket: ManagedObjectConvertible {
    public typealias ManagedObject = TicketCD

    public func toManagedObject(in context: NSManagedObjectContext) -> TicketCD? {
        guard let obj = TicketCD.getOrCreateSingle(with: self.symbol, from: context) else { return nil }
        obj.symbol = self.symbol
        obj.displaySymbol = self.displaySymbol
        obj.descript = self.description
        return obj
    }
}
