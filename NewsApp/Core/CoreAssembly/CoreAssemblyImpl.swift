//
//  CoreAssemblyImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

final class CoreAssemblyImpl: CoreAssembly {
    
    func makeNetworkStack() -> NetworkStack {
        NetworkStackImpl()
    }
    
    func makeCoreDataStack() -> CoreDataStack {
        CoreDataStackImpl()
    }
    
    func makeStorageStack() -> StorageStack {
        StorageStackImpl()
    }
    
}
