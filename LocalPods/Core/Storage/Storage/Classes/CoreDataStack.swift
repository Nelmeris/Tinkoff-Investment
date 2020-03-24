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
    private let bundle: Bundle

    static private var cache: [URL: CoreDataStack] = [:]

    // MARK: - Init

    public static func build(modelName: String, bundle: Bundle) -> CoreDataStack {
        let stack = CoreDataStack(modelName: modelName, bundle: bundle)
        if let stack = cache[stack.modelURL] {
            return stack
        } else {
            stack.registerStore()
            cache[stack.modelURL] = stack
            return stack
        }
    }

    private init(modelName: String, bundle: Bundle) {
        self.modelName = modelName
        self.bundle = bundle
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

    private lazy var modelURL: URL = {
        guard let url = bundle.url(forResource: self.modelName, withExtension: "momd") else { fatalError("Find model failed") }
        return url
    }()

    private lazy var persistentContainer: NSPersistentContainer = {
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else { fatalError("Find model failed") }
        return NSPersistentContainer(name: self.modelName, managedObjectModel: model)
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
