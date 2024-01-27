//
//  ListOfRocketLaunchesViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit

class ListOfRocketsLaunchesViewController: UIViewController {
    let networkService = NetworkService()
    enum Section: Int, CaseIterable {
        case rocketLaunchesInfo
    }
    var testData: [RocketLaunch]? = nil
    private var collectionView: UICollectionView! = nil
    private var dataSource: UICollectionViewDiffableDataSource<Section, RocketLaunch>?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        setupCollectionView()
        createDataSource()
        
        networkService.fetchData(from: "https://api.spacexdata.com/v3/launches") { result in
            switch result {
            case .success(let rocketLaunches):
                self.testData = rocketLaunches
                self.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}
// MARK: - Setup collection view
private extension ListOfRocketsLaunchesViewController {
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.backgroundColor =
        view.addSubview(collectionView)
        collectionView.register(RocketLaunchCell.self, forCellWithReuseIdentifier: RocketLaunchCell.reuseID)
        
    }
}
// MARK: - Create compositional layout
private extension ListOfRocketsLaunchesViewController {
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .rocketLaunchesInfo:

                return self.createRocketLaunches()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
//        config.contentInsetsReference = .none
        layout.configuration = config
        return layout
    }
    func createRocketLaunches() -> NSCollectionLayoutSection {
        let width = UIScreen.main.bounds.width
        let inset = (width - (2 * (width * 0.4))) / 3
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.interItemSpacing = .fixed(inset)
        let section = NSCollectionLayoutSection(group: group)

        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: inset, bottom: 0, trailing: inset)
        section.interGroupSpacing = inset
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
}
// MARK: - Create data source
private extension ListOfRocketsLaunchesViewController {
    func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, RocketLaunch>(collectionView: collectionView, cellProvider: { collectionView, indexPath, rocketLaunch in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknow section kind")
            }
            switch section {
            case .rocketLaunchesInfo:
                let cell = self.configure(collectionView: collectionView, cellType: RocketLaunchCell.self, with: rocketLaunch, for: indexPath)
                cell.networkService = self.networkService
                return cell
            }
        })
    }
}
// MARK: - Reload data
private extension ListOfRocketsLaunchesViewController {
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RocketLaunch>()
        snapshot.appendSections([.rocketLaunchesInfo])
        snapshot.appendItems(testData!, toSection: .rocketLaunchesInfo)
        dataSource?.apply(snapshot, animatingDifferences: true)
        
    }
}
