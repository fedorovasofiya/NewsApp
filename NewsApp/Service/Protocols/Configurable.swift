//
//  Configurable.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

protocol Configurable {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
