//
//  ImageResolverService.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 02.05.2023.
//

import Foundation

protocol ImageResolverService {
    func loadImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
