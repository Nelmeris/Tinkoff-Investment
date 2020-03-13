//
//  CoreDataWorker.swift
//  Pods-Storage_Example
//
//  Created by Artem Kufaev on 09.03.2020.
//

import CoreData
 
public protocol CoreDataWorkerProtocol {
    func get<Entity: ManagedObjectConvertible>
        (with predicate: NSPredicate?,
         sortDescriptors: [NSSortDescriptor]?,
         fetchLimit: Int?,
         completion: @escaping (Result<[Entity], CoreDataWorkerError>) -> Void)
}

public enum CoreDataWorkerError: Error {
    case cannotFetch(String)
    case cannotSave(String)
    case cannotConvertion(String)
}
 
public class CoreDataWorker: CoreDataWorkerProtocol {
    let coreData: CoreDataStack
 
    public init(coreData: CoreDataStack) {
        self.coreData = coreData
    }
 
    public func get<Entity: ManagedObjectConvertible>
        (with predicate: NSPredicate? = nil,
         sortDescriptors: [NSSortDescriptor]? = nil,
         fetchLimit: Int? = nil,
         completion: @escaping (Result<[Entity], CoreDataWorkerError>) -> Void) {
        coreData.performForegroundTask { context in
            do {
                let fetchRequest = Entity.ManagedObject.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                let results =  try context.fetch(fetchRequest) as? [Entity.ManagedObject]
                let items: [Entity] = results?.compactMap { $0.toEntity() as? Entity } ?? []
                completion(.success(items))
            } catch {
                let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                completion(.failure(fetchError))
            }
        }
    }
    
    public func upsert<Entity: ManagedObjectConvertible>
        (_ entity: Entity,
         completion: @escaping (CoreDataWorkerError?) -> Void) {
        coreData.performForegroundTask { context in
            guard entity.toManagedObject(in: context) != nil else {
                let error = CoreDataWorkerError.cannotConvertion("Cannot convert object")
                completion(error)
                return
            }
            do {
                try context.save()
                completion(nil)
            } catch {
                let error = CoreDataWorkerError.cannotSave("Cannot save object error: \(error)")
                completion(error)
            }
        }
    }
    
    public func remove<Entity: ManagedObjectConvertible>
        (_ entity: Entity,
         completion: @escaping (CoreDataWorkerError?) -> Void) {
        coreData.performForegroundTask { context in
            guard let object = entity.toManagedObject(in: context) else {
                completion(.cannotConvertion("Cannot convert object"))
                return
            }
            context.delete(object)
            completion(nil)
        }
    }
    
}
