//
//  NewsListAssemblyImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation
import UIKit

final class NewsListAssemblyImpl: NewsListAssembly {
    
    private let serviceAssembly: ServiceAssembly
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makeNewsListModule(moduleOutput: NewsListModuleOutput) -> UIViewController {
        let presenter = NewsListPresenter(
            newsAPIService: serviceAssembly.makeNewsAPICallerService(),
            imageResolver: serviceAssembly.makeImageResolverService(), newsCacheService: serviceAssembly.makeNewsCacheService(),
            moduleOutput: moduleOutput
        )
        let vc = NewsListViewController(presenter: presenter)
        presenter.viewInput = vc
        
        return vc
    }
    
}
