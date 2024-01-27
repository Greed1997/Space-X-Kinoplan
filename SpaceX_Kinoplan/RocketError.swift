//
//  RocketError.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation

enum RocketError {
    case badURL
    case invalidData
    case decodingError
    case unknownedError
}
extension RocketError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            NSLocalizedString("Не подходящий url адрес", comment: "")
        case .invalidData:
            NSLocalizedString("Не вышло создать data", comment: "")
        case .decodingError:
            NSLocalizedString("Не получилось декодировать данные", comment: "")
        case .unknownedError:
            NSLocalizedString("Неизвестная ошибка", comment: "")
        }
    }
}
