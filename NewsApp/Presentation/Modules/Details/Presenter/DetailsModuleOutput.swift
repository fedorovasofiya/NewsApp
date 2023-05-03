//
//  DetailsModuleOutput.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 02.05.2023.
//

import Foundation

protocol DetailsModuleOutput: AnyObject {
    func moduleWantsToOpenWebView(with url: URL)
}
