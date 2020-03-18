//
//  TicketDataManagerTests.swift
//  FinnhubDataManager_ExampleTests
//
//  Created by Artem Kufaev on 18.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import FinnhubDataManager
import Network
import Storage
import Nimble

class TicketDataManagerTests: XCTestCase {
    
    var provider: ProviderMock!
    var storage: StorageMock!
    var dataManager: TicketDataManager!

    override func setUp() {
        self.provider = ProviderMock()
        self.storage = StorageMock()
        self.dataManager = TicketDataManager(provider: provider, storage: storage)
    }
    
    func testLoad() {
        let tickets = [
            Ticket(symbol: "A", displaySymbol: "A", description: "AAA"),
            Ticket(symbol: "B", displaySymbol: "B", description: "BBB")
        ]
        self.provider.stubbedLoadCompletionResult = .success(tickets)
        self.storage.stubbedReadAllCompletionResult = (tickets, ())
        dataManager.load(exchange: "US") { (result) in
            switch result {
            case .success(let loadedTickets):
                XCTAssertEqual(tickets, loadedTickets)
            case .failure(let error):
                XCTFail("Неожиданная ошибка: \(error)")
            }
        }
        XCTAssert(provider.invokedLoad)
        XCTAssertEqual(provider.invokedLoadCount, 1)
        XCTAssert(storage.invokedReadAll)
        XCTAssertEqual(storage.invokedReadAllCount, 1)
    }

}

extension Ticket: Equatable {
    public static func == (lhs: Ticket, rhs: Ticket) -> Bool {
        return lhs.symbol == rhs.symbol &&
            lhs.displaySymbol == rhs.displaySymbol &&
            lhs.description == rhs.description
    }
}

class ProviderMock: Provider<FinnhubAPI> {
    
    var invokedLoad = false
    var invokedLoadCount = 0
    var stubbedLoadCompletionResult: (NetworkResult<Decodable>)!
    override func load<Model>(_ apiMethod: FinnhubAPI, completion: @escaping (NetworkResult<Model>) -> Void) where Model: Decodable {
        invokedLoad = true
        invokedLoadCount += 1
        switch stubbedLoadCompletionResult! {
        case .success(let decodable):
            completion(.success(decodable as! Model))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    var invokedCancel = false
    var invokedCancelCount = 0
    override func cancel() {
        invokedCancel = true
        invokedCancelCount += 1
        stubbedLoadCompletionResult = nil
    }
}

class StorageMock: Storage<Ticket> {
    
    init() {
        super.init(modelName: "Finnhub", bundle: Bundle(for: TicketDataManager.self))
    }
    
    var invokedReadAll = false
    var invokedReadAllCount = 0
    var stubbedReadAllCompletionResult: ([Ticket], Void)?
    override func readAll(completion: @escaping ([Ticket]) -> Void) {
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
    var stubbedReadCompletionResult: (Ticket?, Void)?
    override func read(id: String, completion: @escaping (Ticket?) -> Void) {
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
    var invokedWriteEntityParameters: (entity: Ticket, Void)?
    var invokedWriteEntityParametersList = [(entity: Ticket, Void)]()
    override func write(_ entity: Ticket) {
        invokedWriteEntity = true
        invokedWriteEntityCount += 1
        invokedWriteEntityParameters = (entity, ())
        invokedWriteEntityParametersList.append((entity, ()))
    }
    
    var invokedWriteEntitiesParameters: (entity: [Ticket], Void)?
    var invokedWriteEntitiesParametersList = [(entity: [Ticket], Void)]()
    override func write(_ entities: [Ticket]) {
        invokedWriteEntity = true
        invokedWriteEntityCount += 1
        invokedWriteEntitiesParameters = (entities, ())
        invokedWriteEntitiesParametersList.append((entities, ()))
    }
    var invokedDeleteEntity = false
    var invokedDeleteEntityCount = 0
    var invokedDeleteEntityParameters: (entity: Ticket, Void)?
    var invokedDeleteEntityParametersList = [(entity: Ticket, Void)]()
    override func delete(_ entity: Ticket) {
        invokedDeleteEntity = true
        invokedDeleteEntityCount += 1
        invokedDeleteEntityParameters = (entity, ())
        invokedDeleteEntityParametersList.append((entity, ()))
    }
    
    var invokedDeleteEntitiesParameters: (entity: [Ticket], Void)?
    var invokedDeleteEntitiesParametersList = [(entity: [Ticket], Void)]()
    override func delete(_ entities: [Ticket]) {
        invokedDeleteEntity = true
        invokedDeleteEntityCount += 1
        invokedDeleteEntitiesParameters = (entities, ())
        invokedDeleteEntitiesParametersList.append((entities, ()))
    }
}
