//
//  WebPresenter.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 03.05.2023.
//

import Foundation

final class WebPresenter {
    
    weak var viewInput: WebViewInput?
    
    private let url: URL
    private weak var moduleOutput: WebModuleOutput?
    
    init(url: URL, moduleOutput: WebModuleOutput? = nil) {
        self.url = url
        self.moduleOutput = moduleOutput
    }
    
}

extension WebPresenter: WebViewOutput {
    
    func viewIsReady() {
        viewInput?.loadURLRequest(URLRequest(url: url))
    }
    
    func didTapClose() {
        moduleOutput?.closeWebView()
    }
    
}
