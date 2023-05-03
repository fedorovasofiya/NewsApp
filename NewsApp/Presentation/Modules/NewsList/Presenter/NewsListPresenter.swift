//
//  NewsListPresenter.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

final class NewsListPresenter {
    
    weak var viewInput: NewsListViewInput?

    private var news = [NewsModel]()
    private var currentPage: Int = 1
    private let newsAPIService: NewsAPICallerService
    private let newsCacheService: NewsCacheService
    private let imageResolver: ImageResolverService
    private weak var moduleOutput: NewsListModuleOutput?
    
    init(newsAPIService: NewsAPICallerService,
         imageResolver: ImageResolverService,
         newsCacheService: NewsCacheService,
         moduleOutput: NewsListModuleOutput?) {
        self.newsAPIService = newsAPIService
        self.newsCacheService = newsCacheService
        self.imageResolver = imageResolver
        self.moduleOutput = moduleOutput
    }
    
    private func loadData() {
        viewInput?.setLoading(enabled: true)
        newsAPIService.getNews(page: currentPage) { result in
            self.viewInput?.setLoading(enabled: false)
            switch result {
            case .success(let models):
                self.news = self.setViewsCounters(for: models)
                self.updateDisplayedData(news: self.news)
                self.saveDataToCache(models: self.news)
                self.currentPage += 1
            case .failure(let error):
                self.viewInput?.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    private func reloadData() {
        newsAPIService.getNews(page: currentPage) { result in
            switch result {
            case .success(let models):
                self.news = self.setViewsCounters(for: models)
                self.updateDisplayedData(news: self.news)
                self.saveDataToCache(models: self.news)
                self.currentPage += 1
            case .failure(let error):
                self.viewInput?.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    private func loadMoreData() {
        newsAPIService.getNews(page: currentPage) { result in
            switch result {
            case .success(let models):
                self.news.append(contentsOf: self.setViewsCounters(for: models))
                self.updateDisplayedData(news: self.news)
                self.currentPage += 1
            case .failure(let error):
                self.viewInput?.showAlert(with: error.localizedDescription)
            }
        }
    }

    private func updateDisplayedData(news: [NewsModel]) {
        let displayData = mapData(models: news)
        viewInput?.showData(displayData)
    }

    private func mapData(models: [NewsModel]) -> [NewsCell.DisplayData] {
        models.map {
            NewsCell.DisplayData(title: $0.title, subTitle: "Number of views: \($0.viewsCounter)")
        }
    }
    
    private func fetchDataFromCache() {
        newsCacheService.fetchNews { result in
            switch result {
            case .failure(let error):
                self.viewInput?.showAlert(with: error.localizedDescription)
            case .success(let models):
                self.news = models
                self.updateDisplayedData(news: models)
            }
        }
    }
    
    private func saveDataToCache(models: [NewsModel]) {
        newsCacheService.saveNews(models: models) { result in
            switch result {
            case .failure(let error):
                self.viewInput?.showAlert(with: error.localizedDescription)
            case .success:
                break
            }
        }
    }
    
    private func increaseCounter(for index: Int) {
        news[index].viewsCounter += 1
        newsCacheService.updateNewsModelCounter(model: news[index]) { result in
            switch result {
            case .failure(let error):
                self.viewInput?.showAlert(with: error.localizedDescription)
            case .success:
                break
            }
        }
        updateDisplayedData(news: news)
    }
    
    private func setViewsCounters(for models: [NewsModel]) -> [NewsModel] {
        models.map { model in
            var newModel = model
            newModel.viewsCounter = self.newsCacheService.getNewsModelCounter(model: model)
            return newModel
        }
    }
}

// MARK: - NewsListViewOutput

extension NewsListPresenter: NewsListViewOutput {
    
    func viewIsReady() {
        fetchDataFromCache()
        loadData()
    }
    
    func reload() {
        news = []
        currentPage = 1
        reloadData()
    }
    
    func loadMore() {
        loadMoreData()
    }
    
    func didSelectItem(at index: Int) {
        guard news.indices.contains(index) else {
            return
        }
        increaseCounter(for: index)
        let selectedModel = news[index]
        moduleOutput?.moduleWantsToOpenDetails(with: selectedModel)
    }
    
    func loadImageData(for index: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        guard news.indices.contains(index),
              let url =  news[index].imageURL
        else {
            completion(.failure(NetworkError.noData))
            return
        }
        imageResolver.loadImageData(from: url, completion: completion)
    }
    
}
