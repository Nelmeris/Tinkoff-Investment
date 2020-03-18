//
//  Storage.swift
//  Pods-Storage_Example
//
//  Created by Artem Kufaev on 09.03.2020.
//

import Foundation

open class Storage<Entity> where Entity: ManagedObjectConvertible {

    private let worker: CoreDataWorker

    public init(modelName: String, bundle: Bundle) {
        let stack = CoreDataStack.build(modelName: modelName, bundle: bundle)
        worker = CoreDataWorker(coreData: stack)
    }
    
    open func readAll(completion: @escaping ([Entity]) -> Void) {
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

    open func read(id: String, completion: @escaping (Entity?) -> Void) {
        worker.get(with: NSPredicate(format: "id == %@", id),
                   sortDescriptors: nil,
                   fetchLimit: nil) { (result: Result<[Entity], CoreDataWorkerError>) in
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

    open func write(_ entity: Entity) {
        worker.upsert(entity) { self.handleError($0) }
    }

    open func write(_ entities: [Entity]) {
        worker.upsert(entities) { self.handleError($0) }
    }

    open func delete(_ entity: Entity) {
        worker.remove(entity) { self.handleError($0) }
    }

    open func delete(_ entities: [Entity]) {
        worker.remove(entities) { self.handleError($0) }
    }

    private func handleError(_ error: CoreDataWorkerError?) {
        guard let error = error else { return }
        print(error.localizedDescription)
    }

}
