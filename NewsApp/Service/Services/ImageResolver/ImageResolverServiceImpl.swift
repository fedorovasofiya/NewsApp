//
//  ImageResolverServiceImpl.swift
//  NewsApp
//
//  Created by Sonya Fedorova on 02.05.2023.
//

import Foundation

final class ImageResolverServiceImpl: ImageResolverService {
    
    private let networkStack: NetworkStack
    private let storageStack: StorageStack
    private let backgroundQueue: DispatchQueue
    
    init(networkStack: NetworkStack,
         storageStack: StorageStack,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.networkStack = networkStack
        self.backgroundQueue = queue
        self.storageStack = storageStack
    }
    
    func loadImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        backgroundQueue.async { [weak self] in
            guard let self = self else { return }
            let fileName = url.lastPathComponent
            if self.isFileExists(fileName: fileName) {
                do {
                    let data = try self.storageStack.read(fileName: fileName)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            } else {
                self.networkStack.loadData(from: url) { result in
                    switch result {
                    case .success(let data):
                        do {
                            try self.storageStack.write(data: data, to: fileName)
                            completion(.success(data))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            }
        }
    }
    
    // MARK: - Private methods
    
    private func isFileExists(fileName: String) -> Bool {
        do {
            return try storageStack.isFileExists(fileName: fileName)
        } catch {
            return false
        }
    }
}
