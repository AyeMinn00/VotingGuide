//
//  ContentViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 17/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialBottomNavigation
import RxSwift
import UIKit

class ContentViewController: InfiniteCollectionViewController<ContentItem> {
    
    private let vm = ContentViewModel()

    override func loadView() {
        super.loadView()
        infiniteListDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        collectionView.backgroundColor = .white
        configAppBarViewController()
        appBarViewController.headerView.trackingScrollView = collectionView
        setTitle("Content")
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(HomeViewDetailController(), animated: true)
    }
}

extension ContentViewController: InfiniteListDelegate {
    func registerCell() {
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: ContentCell.name)
    }

    func getOffSet() -> Int {
        return 300
    }

    func loadData() {
        vm.loadData()
    }

    func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,
            ContentItem>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.state {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell.name, for: indexPath) as? ContentCell
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
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])

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
extension ContentViewController: ErrorCellClickable {
    func didTapRetryButton() {
        loadData()
    }
}
