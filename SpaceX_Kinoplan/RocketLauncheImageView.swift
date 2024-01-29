//
//  RocketLauncheImageView.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 26.01.2024.
//

import UIKit

class RocketLauncheImageView: UIImageView {
    let networkService: NetworkServiceProtocol! = NetworkService()
    let cacheStorage: CacheStorageProtocol! = CacheStorage()
    func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            image = UIImage(named: "Cosmos")
            return
        }
        if let cachedImage = cacheStorage.getCachedImage(from: url) {
            image = cachedImage
            return
        }
        networkService.fetchImage(from: url) { [weak self] data, response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = UIImage(data: data)
                    self.cacheStorage.saveDataToCache(with: data, and: response)
                } else {
                    self.image = UIImage(named: "Cosmos")
                }
            }
        }
    }
}
