//
//  TicketCD+CoreDataClass.swift
//  Tinkoff Tech Authentificator
//
//  Created by Artem Kufaev on 13.03.2020.
//  Copyright © 2020 Tinkoff Courses. All rights reserved.
//
//

import Foundation
import CoreData
import Storage

@objc(TicketCD)
public class TicketCD: NSManagedObject {
    class func getOrCreateSingle(with ticket: Ticket, from context: NSManagedObjectContext) -> TicketCD? {
        let entityName = String(describing: Self.self)
        let request = NSFetchRequest<TicketCD>(entityName: entityName)
        request.predicate = NSPredicate(format: "symbol == %@ AND descript == %@", ticket.symbol, ticket.description)
        guard let result = try? context.fetch(request) else { return nil }
        return result.first ?? TicketCD(context: context)
    }
}

extension TicketCD: ManagedObjectProtocol {
    public typealias Entity = Ticket
    
    public func toEntity() -> TicketCD.Entity? {
        guard let symbol = self.symbol,
            let displaySymbol = self.displaySymbol,
            let description = self.descript else { return nil }
        return Ticket(symbol: symbol, displaySymbol: displaySymbol, description: description)
    }
}
