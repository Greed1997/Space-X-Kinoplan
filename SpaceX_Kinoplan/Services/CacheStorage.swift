//
//  CacheStorage.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 28.01.2024.
//

import UIKit

protocol CacheStorageProtocol: AnyObject {
    func saveDataToCache(with data: Data, and response: URLResponse)
    func getCachedImage(from url: URL) -> UIImage?
}
final class CacheStorage: CacheStorageProtocol {
    func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
