//
//  ListOfRocketLaunchesViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit
protocol ListOfRocketsLaunchesViewControllerInputProtocol: AnyObject {
    func reloadCollectionView(rocketLaunches: [RocketLaunch])
}
protocol ListOfRocketsLaunchesViewControllerOutputProtocol: AnyObject {
    init(view: ListOfRocketsLaunchesViewControllerInputProtocol, router: RouterProtocol)
    func viewDidLoad()
    func dataFetched(rocketLaunches: [RocketLaunch])
    func getSelectedRocketLaunch(index: Int)
}
class ListOfRocketsLaunchesViewController: UIViewController {
    enum Section: Int, CaseIterable {
        case rocketLaunchesInfo
    }
    var presenter: ListOfRocketsLaunchesViewControllerOutputProtocol!
    private var collectionView: UICollectionView! = nil
    private var dataSource: UICollectionViewDiffableDataSource<Section, RocketLaunch>?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        presenter.viewDidLoad()
    }
}
// MARK: - Setup collection view
private extension ListOfRocketsLaunchesViewController {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.backgroundColor =
        view.addSubview(collectionView)
        collectionView.register(RocketLaunchCell.self, forCellWithReuseIdentifier: RocketLaunchCell.reuseID)
        collectionView.delegate = self
        
    }
}
// MARK: - Create compositional layout
private extension ListOfRocketsLaunchesViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
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
        layout.configuration = config
        return layout
    }
    private func createRocketLaunches() -> NSCollectionLayoutSection {
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
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, RocketLaunch>(collectionView: collectionView, cellProvider: { collectionView, indexPath, rocketLaunch in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknow section kind")
            }
            switch section {
            case .rocketLaunchesInfo:
                return self.configure(collectionView: collectionView, cellType: RocketLaunchCell.self, with: rocketLaunch, for: indexPath)
            }
        })
    }
}
// MARK: - ListOfRocketsLaunchesPresenterInput
extension ListOfRocketsLaunchesViewController: ListOfRocketsLaunchesViewControllerInputProtocol {
    internal func reloadCollectionView(rocketLaunches: [RocketLaunch]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RocketLaunch>()
        snapshot.appendSections([.rocketLaunchesInfo])
        snapshot.appendItems(rocketLaunches, toSection: .rocketLaunchesInfo)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
// MARK: - UICollectionViewDelegate
extension ListOfRocketsLaunchesViewController: UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.getSelectedRocketLaunch(index: indexPath.item)
    }
}
