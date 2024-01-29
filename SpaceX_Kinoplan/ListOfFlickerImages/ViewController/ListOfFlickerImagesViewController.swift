//
//  ListOfFlickerImagesViewController.swift
//  SpaceX_Kinoplan
//
//  Created by Александр on 25.01.2024.
//

import UIKit

class ListOfFlickerImagesViewController: UIViewController {
    enum Section: Int, CaseIterable {
        case flickerImages
    }
    var presenter: ListOfFlickerImagesPresenterProtocol!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>?
    private var collectionView: UICollectionView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        presenter.viewDidLoad()
    }
}
// MARK: - Setup collection view
private extension ListOfFlickerImagesViewController {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.register(FlickerImageCell.self, forCellWithReuseIdentifier: FlickerImageCell.reuseID)
    }
}
// MARK: - Create compositional layout
private extension ListOfFlickerImagesViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .flickerImages:
                return self.createFlickerImagesSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        layout.configuration = config
        return layout
    }
    private func createFlickerImagesSection() -> NSCollectionLayoutSection {
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
// MARK: - UICollectionViewDiffableDataSource
private extension ListOfFlickerImagesViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, flickerImageUrlString in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknown section kind")
            }
            switch section {
            case .flickerImages:
                return self.configure(collectionView: collectionView, cellType: FlickerImageCell.self, with: flickerImageUrlString, for: indexPath)
            }
        })
    }
}
// MARK: - ListOfFlickerImagesViewProtocol
extension ListOfFlickerImagesViewController: ListOfFlickerImagesViewProtocol {
    func setTitleVC(title: String) {
        navigationItem.title = title
    }
    
    func reloadCollectionView(flickerImagesUrlString: [String] ) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.flickerImages])
        snapshot.appendItems(flickerImagesUrlString, toSection: .flickerImages)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
