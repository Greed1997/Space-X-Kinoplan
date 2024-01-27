//
//  RocketLauncheImageView.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import UIKit

class RocketLauncheImageView: UIImageView {
    var networkService: NetworkServiceProtocol! = NetworkService()
    func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            image = UIImage(named: "Cosmos")
            return
        }
        
        // Используем изображение из кеша, если оно там есть
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        // Если его нет, то грузим его из сети
        networkService.fetchImage(from: url) { [weak self] data, response in
            guard let self = self else { return }
            self.image = UIImage(data: data)
            
            self.saveDataToCache(with: data, and: response)
        }
    }
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
