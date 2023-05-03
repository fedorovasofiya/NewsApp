//
//  StorageStack.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 03.05.2023.
//

import Foundation

protocol StorageStack {
    func read(fileName: String) throws -> Data
    func write(data: Data, to fileName: String) throws
    func isFileExists(fileName: String) throws -> Bool
}
