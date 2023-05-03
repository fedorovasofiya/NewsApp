//
//  CoreDataError.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 26.04.2023.
//

import Foundation

enum CoreDataError: Error {
    case saveFailed
    case invalidDataID
    case fetchFailed
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .saveFailed:
            return "Can't save data to cache"
        case .invalidDataID:
            return "Can't find item in cache because of invalid ID"
        case .fetchFailed:
            return "Can't fetch data from cache"
        }
    }
}
