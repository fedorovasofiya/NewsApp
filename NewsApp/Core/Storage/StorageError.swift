//
//  StorageError.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 03.05.2023.
//

import Foundation

enum StorageError: Error {
    case invalidDirectory
    case writeFailed
    case readFailed
}

extension StorageError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidDirectory:
            return "Internal error: invalid directory"
        case .readFailed:
            return "Can't read file"
        case .writeFailed:
            return "Can't write to file"
        }
    }
}

