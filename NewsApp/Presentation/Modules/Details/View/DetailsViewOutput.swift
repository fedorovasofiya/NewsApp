//
//  DetailsViewOutput.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 02.05.2023.
//

import Foundation

protocol DetailsViewOutput: AnyObject {
    func viewIsReady()
    func reload()
    func didTapReadMore()
}
