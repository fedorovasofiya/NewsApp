//
//  NetworkError.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 26.04.2023.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidURL
    case redirect
    case badRequest
    case serverError
    case unexpectedStatus
    case emptyURLRequest
    case noInternetConnection
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "No data"
        case .invalidURL:
            return "Invalid URL"
        case .redirect:
            return "Redirect"
        case .badRequest:
            return "Bad request"
        case .serverError:
            return "Server error"
        case .unexpectedStatus:
            return "Unexpected status"
        case .noInternetConnection:
            return "No internet connection"
        case .emptyURLRequest:
            return "There is no URL request to send"
        }
    }
}
