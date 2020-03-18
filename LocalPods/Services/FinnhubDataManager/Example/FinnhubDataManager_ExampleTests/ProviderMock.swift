//
//  ProviderMock.swift
//  FinnhubDataManager_ExampleTests
//
//  Created by Artem Kufaev on 18.03.2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Network
import FinnhubDataManager

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
