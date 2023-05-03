//
//  WebViewInput.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 03.05.2023.
//

import Foundation

protocol WebViewInput: AnyObject {
    func loadURLRequest(_ request: URLRequest)
}
