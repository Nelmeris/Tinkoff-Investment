//
//  StorageMock.swift
//  FinnhubDataManager_ExampleTests
//
//  Created by Artem Kufaev on 18.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Storage
import FinnhubDataManager

class StorageMock<Model: ManagedObjectConvertible>: Storage<Model> {
    
    init() {
        super.init(modelName: "Finnhub", bundle: Bundle(for: TicketDataManager.self))
    }
    
    var invokedReadAll = false
    var invokedReadAllCount = 0
    var stubbedReadAllCompletionResult: ([Model], Void)?
    override func readAll(completion: @escaping ([Model]) -> Void) {
        invokedReadAll = true
        invokedReadAllCount += 1
        if let result = stubbedReadAllCompletionResult {
            completion(result.0)
        }
    }
    var invokedRead = false
    var invokedReadCount = 0
    var invokedReadParameters: (id: String, Void)?
    var invokedReadParametersList = [(id: String, Void)]()
    var stubbedReadCompletionResult: (Model?, Void)?
    override func read(id: String, completion: @escaping (Model?) -> Void) {
        invokedRead = true
        invokedReadCount += 1
        invokedReadParameters = (id, ())
        invokedReadParametersList.append((id, ()))
        if let result = stubbedReadCompletionResult {
            completion(result.0)
        }
    }
    var invokedWriteEntity = false
    var invokedWriteEntityCount = 0
    var invokedWriteEntityParameters: (entity: Model, Void)?
    var invokedWriteEntityParametersList = [(entity: Model, Void)]()
    override func write(_ entity: Model) {
        invokedWriteEntity = true
        invokedWriteEntityCount += 1
        invokedWriteEntityParameters = (entity, ())
        invokedWriteEntityParametersList.append((entity, ()))
    }
    
    var invokedWriteEntitiesParameters: (entity: [Model], Void)?
    var invokedWriteEntitiesParametersList = [(entity: [Model], Void)]()
    override func write(_ entities: [Model]) {
        invokedWriteEntity = true
        invokedWriteEntityCount += 1
        invokedWriteEntitiesParameters = (entities, ())
        invokedWriteEntitiesParametersList.append((entities, ()))
    }
    var invokedDeleteEntity = false
    var invokedDeleteEntityCount = 0
    var invokedDeleteEntityParameters: (entity: Model, Void)?
    var invokedDeleteEntityParametersList = [(entity: Model, Void)]()
    override func delete(_ entity: Model) {
        invokedDeleteEntity = true
        invokedDeleteEntityCount += 1
        invokedDeleteEntityParameters = (entity, ())
        invokedDeleteEntityParametersList.append((entity, ()))
    }
    
    var invokedDeleteEntitiesParameters: (entity: [Model], Void)?
    var invokedDeleteEntitiesParametersList = [(entity: [Model], Void)]()
    override func delete(_ entities: [Model]) {
        invokedDeleteEntity = true
        invokedDeleteEntityCount += 1
        invokedDeleteEntitiesParameters = (entities, ())
        invokedDeleteEntitiesParametersList.append((entities, ()))
    }
}
