//
//  NewsCacheServiceImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation
import CoreData

final class NewsCacheServiceImpl: NewsCacheService {
    
    // MARK: - Private Properties
    
    private var viewContext: NSManagedObjectContext {
        coreDataStack.viewContext
    }
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    // MARK: - Public Methods
    
    func fetchNews(completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        do {
            let fetchRequest = DBNews.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "publishedAt", ascending: false)]
            let data: [NewsModel] = try viewContext.fetch(fetchRequest).compactMap({ dbNews in
                guard let title = dbNews.title,
                      let urlString = dbNews.url,
                      let url = URL(string: urlString),
                      let publishedAt = dbNews.publishedAt,
                      let source = dbNews.source
                else {
                    return nil
                }
                return NewsModel(
                    title: title,
                    text: dbNews.text,
                    publishedAt: publishedAt,
                    imageURL: URL(string: dbNews.imageURL ?? ""),
                    source: source,
                    url: url,
                    viewsCounter: dbNews.viewsCounter
                )
            })
            completion(.success(data))
        } catch {
            completion(.failure(CoreDataError.fetchFailed))
        }
    }
    
    func saveNews(models: [NewsModel], completion: @escaping (Result<Void, Error>) -> Void) {
        coreDataStack.save(completion: completion) { [weak self] context in
            models.forEach { model in
                var dbNews: DBNews
                if let existingDBNews = self?.findDBNews(title: model.title, context: context) {
                    dbNews = existingDBNews
                } else {
                    dbNews = DBNews(context: context)
                    dbNews.viewsCounter = model.viewsCounter
                }
                dbNews.title = model.title
                dbNews.imageURL = model.imageURL?.absoluteString
                dbNews.publishedAt = model.publishedAt
                dbNews.source = model.source
                dbNews.text = model.text
                dbNews.url = model.url.absoluteString
            }
        }
    }
    
    func updateNewsModelCounter(model: NewsModel, completion: @escaping (Result<Void, Error>) -> Void) {
        coreDataStack.save(completion: completion) { [weak self] context in
            var dbNews: DBNews
            if let existingDBNews = self?.findDBNews(title: model.title, context: context) {
                dbNews = existingDBNews
            } else {
                dbNews = DBNews(context: context)
            }
            dbNews.viewsCounter = model.viewsCounter
        }
    }
    
    func getNewsModelCounter(model: NewsModel) -> Int16 {
        do {
            let fetchRequest = DBNews.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "title == %@", model.title as CVarArg)
            guard let dbNews = try viewContext.fetch(fetchRequest).first else {
                return 0
            }
            return dbNews.viewsCounter
        } catch {
            return 0
        }
    }
    
    func deleteNews(completion: @escaping (Result<Void, Error>) -> Void) {
        coreDataStack.save(completion: completion) { context in
            let fetchRequest = DBNews.fetchRequest()
            if let dbNews = try? context.fetch(fetchRequest) {
                dbNews.forEach({ dbNews in
                    context.delete(dbNews)
                })
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func findDBNews(title: String, context: NSManagedObjectContext) -> DBNews? {
        let fetchRequest = DBNews.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", title as CVarArg)
        return try? context.fetch(fetchRequest).first
    }
    
}
