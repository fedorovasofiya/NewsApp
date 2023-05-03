//
//  NewsCacheService.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

protocol NewsCacheService: AnyObject {
    func fetchNews(completion: @escaping (Result<[NewsModel], Error>) -> Void)
    func saveNews(models: [NewsModel], completion: @escaping (Result<Void, Error>) -> Void)
    func updateNewsModelCounter(model: NewsModel, completion: @escaping (Result<Void, Error>) -> Void)
    func getNewsModelCounter(model: NewsModel) -> Int16
    func deleteNews(completion: @escaping (Result<Void, Error>) -> Void)
}
