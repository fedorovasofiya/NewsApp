//
//  ServiceAssembly.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

protocol ServiceAssembly {
    func makeNewsCacheService() -> NewsCacheService
    func makeNewsAPICallerService() -> NewsAPICallerService
    func makeImageResolverService() -> ImageResolverService
}
