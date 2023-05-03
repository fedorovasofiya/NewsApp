//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 05.02.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: RootCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let serviceAssembly = ServiceAssemblyImpl(coreAssembly: CoreAssemblyImpl())
        coordinator = RootCoordinatorImpl(
            newsListAssembly: NewsListAssemblyImpl(serviceAssembly: serviceAssembly),
            detailsAssembly: DetailsAssemblyImpl(serviceAssembly: serviceAssembly),
            webAssembly: WebAssemblyImpl()
        )
        coordinator?.start(in: window)
        
        return true
    }

}
