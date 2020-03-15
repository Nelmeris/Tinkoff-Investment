//
//  Storage.swift
//  Pods-Storage_Example
//
//  Created by Artem Kufaev on 09.03.2020.
//

import Foundation

public class Storage<Entity> where Entity: ManagedObjectConvertible {
    
    private let worker: CoreDataWorker
    
    public init(modelName: String) {
        let stack = CoreDataStack(modelName: modelName)
        worker = CoreDataWorker(coreData: stack)
    }
    
    public func readAll(completion: @escaping ([Entity]) -> Void) {
        worker.get { (result: Result<[Entity], CoreDataWorkerError>) in
            switch result {
            case .success(let entities):
                completion(entities)
            case .failure(let error):
            self.handleError(error)
                completion([])
            }
        }
    }
    
    public func read(id: String, completion: @escaping (Entity?) -> Void) {
        worker.get(with: NSPredicate(format: "id == %@", id),
                   sortDescriptors: nil,
                   fetchLimit: nil)
        { (result: Result<[Entity], CoreDataWorkerError>) in
            switch result {
            case .success(let entities):
                let entity = entities.first
                completion(entity)
            case .failure(let error):
                self.handleError(error)
                completion(nil)
            }
        }
    }

    public func write(_ entity: Entity) {
        worker.upsert(entity) { self.handleError($0) }
    }
    
    public func write(_ entities: [Entity]) {
        worker.upsert(entities) { self.handleError($0) }
    }
    
    public func delete(_ entity: Entity) {
        worker.remove(entity) { self.handleError($0) }
    }
    
    public func delete(_ entities: [Entity]) {
        worker.remove(entities) { self.handleError($0) }
    }
    
    private func handleError(_ error: CoreDataWorkerError?) {
        guard let error = error else { return }
        print(error.localizedDescription)
    }
    
}
