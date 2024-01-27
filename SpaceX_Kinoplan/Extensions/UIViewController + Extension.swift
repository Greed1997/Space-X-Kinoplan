//
//  UIViewController + Extension.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit

extension UIViewController {
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseID, for: indexPath) as? T else {
            fatalError("Unable to deque reusable cell")
        }
        cell.configure(with: value)
        return cell
    }
}
