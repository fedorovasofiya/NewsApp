//
//  NewsAPICallerService.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 26.04.2023.
//

import Foundation

protocol NewsAPICallerService: AnyObject {
    func getNews(page: Int, completion: @escaping (Result<[NewsModel], Error>) -> Void)
}
