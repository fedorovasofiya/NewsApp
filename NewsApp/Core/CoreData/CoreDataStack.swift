//
//  CoreDataStack.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 26.04.2023.
//

import CoreData

protocol CoreDataStack: AnyObject {
    var viewContext: NSManagedObjectContext { get }
    func save(completion: @escaping (Result<Void, Error>) -> Void, block: @escaping (NSManagedObjectContext) throws -> Void)
}
