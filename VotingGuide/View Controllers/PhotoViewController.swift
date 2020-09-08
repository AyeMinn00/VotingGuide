//
//  PhotoViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 30/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class PhotoViewController: VotingGuideViewController, UICollectionViewDelegate {
    var collectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<Section, String?>!

    var contentImages: [String?]?
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configCollectionView()
        if let images = contentImages {
            applySnapshot(items: images)
        }
    }

    private func configCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.name)
        collectionView.delegate = self
        makeDataSource()
    }

    private func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, String?>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, str) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.name, for: indexPath) as? PhotoCell
            cell?.bind(str)
            return cell
        })
    }

    private func createCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .paging
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func applySnapshot(items: [String?], _ animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String?>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        collectionView.selectItem(at: IndexPath(index: selectedIndex), animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension PhotoViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
