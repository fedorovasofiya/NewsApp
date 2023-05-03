//
//  NewsListViewOutput.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

protocol NewsListViewOutput: AnyObject {
    func viewIsReady()
    func reload()
    func loadMore()
    func didSelectItem(at index: Int)
    func loadImageData(for index: Int, completion: @escaping (Result<Data, Error>) -> Void)
}
