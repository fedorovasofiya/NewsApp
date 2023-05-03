//
//  NewsAPICallerServiceImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 26.04.2023.
//

import Foundation

final class NewsAPICallerServiceImpl: NewsAPICallerService {
    
    // MARK: - Private Properties
    
    private struct Configuration {
        static let host = "newsapi.org"
        static let apiKey = "e9cb23c4f6274e92bbfb542f5cadd1ac"
    }
    
    private let networkStack: NetworkStack
    private let backgroundQueue: DispatchQueue
    
    init(networkStack: NetworkStack,
         queue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)) {
        self.networkStack = networkStack
        self.backgroundQueue = queue
    }
    
    // MARK: - Public Methods
    
    func getNews(page: Int, completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        guard (page > 0 && page < 6) else {
            completion(.failure(NetworkError.noData))
            return
        }
        backgroundQueue.async {
            guard let request = self.createRequest(page: page) else {
                completion(.failure(NetworkError.emptyURLRequest))
                return
            }
            self.networkStack.sendRequest(request) { (result: Result<APIResponse, Error>) in
                switch result {
                case .success(let response):
                    let data = response.articles
                    let result = self.mapData(models: data)
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func mapData(models: [Article]) -> [NewsModel] {
        return models.compactMap { model in
            guard let date = formateDate(model.publishedAt),
                  let url = URL(string: model.url) else {
                return nil
            }
            return NewsModel(
                title: model.title,
                text: model.description,
                publishedAt: date,
                imageURL: URL(string: model.urlToImage ?? ""),
                source: model.source.name,
                url: url,
                viewsCounter: 0
            )
        }
    }
    
    private func formateDate(_ date: String) -> String? {
        let formatterToDate = DateFormatter()
        formatterToDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let formatterToString = DateFormatter()
        formatterToString.locale = Locale(identifier: "en_US_POSIX")
        formatterToString.dateFormat = "dd MMMM yyyy"
        guard let date = formatterToDate.date(from: date) else {
            return nil
        }
        return formatterToString.string(from: date)
    }
    
    private func createRequest(page: Int) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = Configuration.host
        urlComponents.path = "/v2/everything"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "sport"),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pageSize", value: "20"),
            URLQueryItem(name: "apiKey", value: Configuration.apiKey)
        ]
        guard let url = urlComponents.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
}
