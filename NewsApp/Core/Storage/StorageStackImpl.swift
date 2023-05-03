//
//  StorageStackImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 03.05.2023.
//

import Foundation

final class StorageStackImpl: StorageStack {
    
    // MARK: - Private Properties
    
    private let fileManager = FileManager.default
    
    // MARK: - Public Methods
    
    func read(fileName: String) throws -> Data {
        guard let directory = getDocumentsDirectory() else {
            throw StorageError.invalidDirectory
        }
        let url = directory.appendingPathComponent(fileName, isDirectory: false)
        guard let data = try? Data(contentsOf: url) else {
            throw StorageError.readFailed
        }
        return data
    }
    
    func write(data: Data, to fileName: String) throws {
        guard let directory = getDocumentsDirectory() else {
            throw StorageError.invalidDirectory
        }
        let url = directory.appendingPathComponent(fileName)
        if !fileManager.fileExists(atPath: url.path) {
            fileManager.createFile(atPath: url.path, contents: nil, attributes: nil)
        }
        do {
            try data.write(to: url)
        } catch {
            throw StorageError.writeFailed
        }
    }
    
    func isFileExists(fileName: String) throws -> Bool {
        guard let directory = getDocumentsDirectory() else {
            throw StorageError.invalidDirectory
        }
        let url = directory.appendingPathComponent(fileName)
        return fileManager.fileExists(atPath: url.path)
    }
    
    // MARK: - Private Methods
    
    private func getDocumentsDirectory() -> URL? {
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return url.first
    }
    
}

