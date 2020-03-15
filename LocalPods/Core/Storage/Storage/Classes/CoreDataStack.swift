//
//  CoreDataStack.swift
//  Pods-Storage_Example
//
//  Created by Artem Kufaev on 04.03.2020.
//

import CoreData

public final class CoreDataStack {
    
    private let modelName: String
    private let storeIsReady = DispatchGroup()
    
    // MARK: - Init
    
    public init(modelName: String) {
        self.modelName = modelName
        registerStore()
    }
    
    // MARK: - Public
    
    public lazy var mainContext: NSManagedObjectContext = {
        storeIsReady.wait()
        return persistentContainer.viewContext
    }()
    
    public func makePrivateContext() -> NSManagedObjectContext {
        storeIsReady.wait()
        return persistentContainer.newBackgroundContext()
    }
    
    public func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        storeIsReady.wait()
        mainContext.perform {
            block(self.mainContext)
        }
    }
    
    public func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        storeIsReady.wait()
        persistentContainer.performBackgroundTask(block)
    }
    
    // MARK: - Private
    
    private lazy var persistentContainer: NSPersistentContainer = {
        return NSPersistentContainer(name: self.modelName)
    }()
    
    private func registerStore() {
        storeIsReady.enter()
        
        DispatchQueue.global(qos: .background).async {
            self.persistentContainer.loadPersistentStores { (storeDescription, error) in
                if let url = storeDescription.url {
                    debugPrint("Persistent store created: \(url.absoluteString)")
                }
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
                self.storeIsReady.leave()
            }
        }
    }
    
}
