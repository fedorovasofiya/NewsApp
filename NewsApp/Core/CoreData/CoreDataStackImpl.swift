//
//  CoreDataStackImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 26.04.2023.
//

import CoreData

final class CoreDataStackImpl: CoreDataStack {
    
    // MARK: - Private Properties
        
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "News")
        persistentContainer.loadPersistentStores { _, error in
            guard let error else { return }
            print(error)
        }
        return persistentContainer
    }()
    
    // MARK: - Public Properties
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Public Methods
    
    func save(completion: @escaping (Result<Void, Error>) -> Void, block: @escaping (NSManagedObjectContext) throws -> Void) {
        let backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.perform {
            do {
                try block(backgroundContext)
                if backgroundContext.hasChanges {
                    try backgroundContext.save()
                }
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }

}
