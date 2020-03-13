//
//  Exchange+CoreDataClass.swift
//  Pods-TicketList_Example
//
//  Created by Artem Kufaev on 13.03.2020.
//
//

import CoreData
import Storage

@objc(Exchange)
public class ExchangeCD: NSManagedObject {
    public class func getOrCreateSingle(with code: String, from context: NSManagedObjectContext) -> ExchangeCD? {
        let entityName = String(describing: Self.self)
        let request = NSFetchRequest<ExchangeCD>(entityName: entityName)
        request.predicate = NSPredicate(format: "code == %@", code)
        guard let result = try? context.fetch(request) else { return nil }
        return result.first ?? ExchangeCD(context: context)
    }
}

extension ExchangeCD: ManagedObjectProtocol {
    public typealias Entity = Exchange
    
    public func toEntity() -> ExchangeCD.Entity? {
        guard let code = self.code,
            let name = self.name,
            let currency = self.currency else { return nil }
        return Exchange(name: name, code: code, currency: currency)
    }
}
