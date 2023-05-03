//
//  DetailsAssemblyImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 02.05.2023.
//

import Foundation
import UIKit

final class DetailsAssemblyImpl: DetailsAssembly {
    
    private let serviceAssembly: ServiceAssembly
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func makeDetailsModule(newsModel: NewsModel, moduleOutput: DetailsModuleOutput) -> UIViewController {
        let presenter = DetailsPresenter(
            news: newsModel,
            imageResolver: serviceAssembly.makeImageResolverService(),
            moduleOutput: moduleOutput
        )
        let vc = DetailsViewController(presenter: presenter)
        presenter.viewInput = vc
        
        return vc
    }
    
}
