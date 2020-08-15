//
//  HomeViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit
import RxSwift

class GalleryViewController: InfiniteCollectionViewController<ImageSetItem> {
    private let vm = GalleryViewModel()

    override func loadView() {
        super.loadView()
        infiniteListDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        collectionView.backgroundColor = .systemGray6
        loadData()
    }
    
}

extension GalleryViewController: InfiniteListDelegate {
    func registerCell() {
        collectionView.register(ImageSetCell.self, forCellWithReuseIdentifier: ImageSetCell.name)
    }

    func getOffSet() -> Int {
        return 300
    }

    func loadData() {
        log(msg: "loadData()")
        vm.loadData()
    }

    func makeDataSource() {
        log(msg: "makeDataSource")
        dataSource = UICollectionViewDiffableDataSource<Section, ImageSetItem>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.state {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSetCell.name, for: indexPath) as? ImageSetCell
                cell?.bind(item.value)
                return cell
            case .loading:
                return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.name, for: indexPath) as? LoadingCell
            case .error:
                let errorCell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCell.name, for: indexPath) as? ErrorCell
                errorCell?.errorCellClickable = self
                return errorCell
            case .finished:
                return collectionView.dequeueReusableCell(withReuseIdentifier: EndCell.name, for: indexPath) as? EndCell
            }
        })
    }

    func createCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func watchData() {
        vm.responses.subscribeOn(MainScheduler.instance)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] imageSets in
            self?.applySnapshot(items: imageSets)
        }).disposed(by: disposeBag)
    }
}

// Mark
extension GalleryViewController: ErrorCellClickable {
    func didTapRetryButton() {
    }
}
