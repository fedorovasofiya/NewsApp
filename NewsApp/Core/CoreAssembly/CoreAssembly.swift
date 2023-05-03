//
//  CoreAssembly.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

protocol CoreAssembly {
    func makeNetworkStack() -> NetworkStack
    func makeCoreDataStack() -> CoreDataStack
    func makeStorageStack() -> StorageStack
}
