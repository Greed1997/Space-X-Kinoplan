//
//  SelfConfiguringCell.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseID: String { get }
    func configure<U: Hashable>(with value: U)
}
