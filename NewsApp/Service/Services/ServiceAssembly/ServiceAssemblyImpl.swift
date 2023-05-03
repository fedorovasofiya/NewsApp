//
//  ServiceAssemblyImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

final class ServiceAssemblyImpl: ServiceAssembly {
    
    // MARK: - Private Properties

    private let coreAssembly: CoreAssembly

    private lazy var coreDataStack: CoreDataStack = {
        coreAssembly.makeCoreDataStack()
    }()
    
    // MARK: - Init
    
    init(coreAssembly: CoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    // MARK: - Public Methods
    
    func makeNewsCacheService() -> NewsCacheService {
        NewsCacheServiceImpl(coreDataStack: coreDataStack)
    }
    
    func makeNewsAPICallerService() -> NewsAPICallerService {
        NewsAPICallerServiceImpl(networkStack: coreAssembly.makeNetworkStack())
    }
    
    func makeImageResolverService() -> ImageResolverService {
        ImageResolverServiceImpl(
            networkStack: coreAssembly.makeNetworkStack(),
            storageStack: coreAssembly.makeStorageStack()
        )
    }
    
}
