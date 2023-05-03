//
//  WebAssemblyImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 03.05.2023.
//

import Foundation
import UIKit

final class WebAssemblyImpl: WebAssembly {
    
    func makeWebModule(url: URL, moduleOutput: WebModuleOutput) -> UIViewController {
        let presenter = WebPresenter(url: url, moduleOutput: moduleOutput)
        let vc = WebViewController(presenter: presenter)
        presenter.viewInput = vc
        return vc
    }
    
}
