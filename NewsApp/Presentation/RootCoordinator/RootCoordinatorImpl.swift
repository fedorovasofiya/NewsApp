//
//  RootCoordinatorImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation
import UIKit

final class RootCoordinatorImpl: RootCoordinator {

    private weak var window: UIWindow?
    private let newsListAssembly: NewsListAssembly
    private let detailsAssembly: DetailsAssembly
    private let webAssembly: WebAssembly
    private var navigationController: UINavigationController?

    init(newsListAssembly: NewsListAssembly, detailsAssembly: DetailsAssembly, webAssembly: WebAssembly) {
        self.newsListAssembly = newsListAssembly
        self.detailsAssembly = detailsAssembly
        self.webAssembly = webAssembly
    }

    func start(in window: UIWindow) {
        let vc = newsListAssembly.makeNewsListModule(moduleOutput: self)
        self.navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
    
}

extension RootCoordinatorImpl: NewsListModuleOutput {
    func moduleWantsToOpenDetails(with model: NewsModel) {
        let vc = detailsAssembly.makeDetailsModule(newsModel: model, moduleOutput: self)
        (window?.rootViewController as? UINavigationController)?.pushViewController(vc, animated: true)
    }
}

extension RootCoordinatorImpl: DetailsModuleOutput {
    func moduleWantsToOpenWebView(with url: URL) {
        let vc = webAssembly.makeWebModule(url: url, moduleOutput: self)
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController?.present(navigationController, animated: true)
    }
}

extension RootCoordinatorImpl: WebModuleOutput {
    func closeWebView() {
        window?.rootViewController?.dismiss(animated: true)
    }
}
