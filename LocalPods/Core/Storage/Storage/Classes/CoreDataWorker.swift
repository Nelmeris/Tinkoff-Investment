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

public enum CoreDataWorkerError: Error, LocalizedError {
    case cannotFetch(Error)
    case cannotSave(Error)
    case cannotConvertion
    case cannotDelete(Error)
    
    public var localizedDescription: String {
        switch self {
        case .cannotFetch(let error):
            return "Cannot fetch error: \(error))"
        case .cannotConvertion:
            return "Cannot convert object"
        case .cannotDelete(let error):
            return "Cannot delete object error: \(error)"
        case .cannotSave(let error):
            return "Cannot save object error: \(error)"
        }
    }
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
                let fetchError = CoreDataWorkerError.cannotFetch(error)
                completion(.failure(fetchError))
            }
        }
    }
    
    private func upsertProccess<Entity: ManagedObjectConvertible>
        (_ entity: Entity,
        in context: NSManagedObjectContext,
        completion: @escaping (CoreDataWorkerError?) -> Void) {
        guard entity.toManagedObject(in: context) != nil else {
            completion(.cannotConvertion)
            return
        }
        do {
            try context.save()
            completion(nil)
        } catch {
            completion(.cannotSave(error))
        }
    }
    
    public func upsert<Entity: ManagedObjectConvertible>
        (_ entity: Entity,
         completion: @escaping (CoreDataWorkerError?) -> Void) {
        coreData.performBackgroundTask { context in
            self.upsertProccess(entity, in: context, completion: completion)
        }
    }
    
    public func upsert<Entity: ManagedObjectConvertible>
        (_ entities: [Entity],
         completion: @escaping (CoreDataWorkerError?) -> Void) {
        coreData.performBackgroundTask { context in
            entities.forEach {
                self.upsertProccess($0, in: context, completion: completion)
            }
        }
    }
    
    private func removeProccess<Entity: ManagedObjectConvertible>
        (_ entity: Entity,
         in context: NSManagedObjectContext,
         completion: @escaping (CoreDataWorkerError?) -> Void) {
        guard let object = entity.toManagedObject(in: context) else {
            completion(.cannotConvertion)
            return
        }
        context.delete(object)
        do {
            try context.save()
            completion(nil)
        } catch {
            completion(.cannotDelete(error))
        }
    }
    
    public func remove<Entity: ManagedObjectConvertible>
        (_ entity: Entity,
         completion: @escaping (CoreDataWorkerError?) -> Void) {
        coreData.performBackgroundTask { context in
            self.removeProccess(entity, in: context, completion: completion)
        }
    }
    
    public func remove<Entity: ManagedObjectConvertible>
        (_ entities: [Entity],
         completion: @escaping (CoreDataWorkerError?) -> Void) {
         coreData.performBackgroundTask { context in
            entities.forEach {
                self.removeProccess($0, in: context, completion: completion)
            }
         }
    }
}
