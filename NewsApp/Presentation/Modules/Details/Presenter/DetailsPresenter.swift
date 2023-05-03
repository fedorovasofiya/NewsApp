//
//  DetailsPresenter.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 02.05.2023.
//

import Foundation
import UIKit

final class DetailsPresenter {
    
    weak var viewInput: DetailsViewInput?
    
    private var news: NewsModel
    private weak var moduleOutput: DetailsModuleOutput?
    private let imageResolver: ImageResolverService
    
    init(news: NewsModel,
         imageResolver: ImageResolverService,
         moduleOutput: DetailsModuleOutput?) {
        self.news = news
        self.imageResolver = imageResolver
        self.moduleOutput = moduleOutput
    }
    
    private func loadImage() {
        guard let url = news.imageURL else { return }
        imageResolver.loadImageData(from: url) { [weak self] result in
            switch result {
            case let .success(data):
                self?.viewInput?.showImage(UIImage(data: data))
            case .failure:
                self?.viewInput?.showAlert(with: L10n.noImageError)
            }
        }
    }
}

extension DetailsPresenter: DetailsViewOutput {
    
    func viewIsReady() {
        viewInput?.showData(news)
        loadImage()
    }
    
    func reload() {
        loadImage()
    }
    
    func didTapReadMore() {
        moduleOutput?.moduleWantsToOpenWebView(with: news.url)
    }
    
}
