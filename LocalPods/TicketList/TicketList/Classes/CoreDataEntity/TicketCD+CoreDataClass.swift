//
//  TicketCD+CoreDataClass.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//
//

import CoreData
import Storage

@objc(Ticket)
public class TicketCD: NSManagedObject {
    public class func getOrCreateSingle(with symbol: String, from context: NSManagedObjectContext) -> TicketCD? {
        let entityName = String(describing: Self.self)
        let request = NSFetchRequest<TicketCD>(entityName: entityName)
        request.predicate = NSPredicate(format: "symbol == %@", symbol)
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
