//
//  NewsModel.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 27.04.2023.
//

import Foundation

struct NewsModel {
    let title: String
    let text: String?
    let publishedAt: String
    let imageURL: URL?
    let source: String
    let url: URL
    var viewsCounter: Int16
}
