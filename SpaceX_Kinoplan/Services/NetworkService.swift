//
//  NetworkService.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from urlString: String, completion: @escaping ((Result<[RocketLaunch], RocketError>) -> Void))
    func fetchData(from urlString: String) async throws -> [RocketLaunch]
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void)
}
final class NetworkService: NetworkServiceProtocol {
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
            
        }.resume()
    }
    
    
    func fetchData(from urlString: String, completion: @escaping ((Result<[RocketLaunch], RocketError>) -> Void)) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error != nil {
                completion(.failure(.unknownedError))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            let decoder = JSONDecoder()
            do {
                let rocketLaunch = try decoder.decode([RocketLaunch].self, from: data)
                completion(.success(rocketLaunch))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    func fetchData(from urlString: String) async throws -> [RocketLaunch] {
        guard let url = URL(string: urlString) else {
            throw RocketError.badURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let rocketLaunch = try JSONDecoder().decode([RocketLaunch].self, from: data)
            return rocketLaunch
        } catch {
            throw error
        }
    }
}
