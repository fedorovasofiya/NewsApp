//
//  NewsListViewInput.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

protocol NewsListViewInput: AnyObject {
    func setLoading(enabled: Bool)
    func showData(_ data: [NewsCell.DisplayData])
    func showAlert(with errorMessage: String)
}
