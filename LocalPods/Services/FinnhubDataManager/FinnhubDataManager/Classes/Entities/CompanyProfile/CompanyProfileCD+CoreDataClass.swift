//
//  CompanyProfileCD+CoreDataClass.swift
//  FinnhubDataManager
//
//  Created by Artem Kufaev on 17.03.2020.
//
//

import Foundation
import CoreData
import Storage

@objc(CompanyProfileCD)
public class CompanyProfileCD: NSManagedObject {
    public class func getOrCreateSingle(with ticker: String, from context: NSManagedObjectContext) -> CompanyProfileCD? {
        let entityName = String(describing: Self.self)
        let request = NSFetchRequest<CompanyProfileCD>(entityName: entityName)
        request.predicate = NSPredicate(format: "ticker == %@", ticker)
        guard let result = try? context.fetch(request) else { return nil }
        return result.first ?? CompanyProfileCD(context: context)
    }
}

extension CompanyProfileCD: ManagedObjectProtocol {
    public typealias Entity = CompanyProfile

    public func toEntity() -> CompanyProfile? {
        guard let ticker = self.ticker,
            let name = self.name,
            let currency = self.currency,
            let description = self.descript else { return nil }
        return CompanyProfile(ticker: ticker, name: name, currency: currency, description: description)
    }
}
