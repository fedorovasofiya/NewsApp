//
//  NewsListModuleOutput.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

protocol NewsListModuleOutput: AnyObject {
    func moduleWantsToOpenDetails(with model: NewsModel)
}
