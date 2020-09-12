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
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action:
            #selector(handleRefreshControl),
            for: .valueChanged)
        configAppBarViewController()
        appBarViewController.headerView.trackingScrollView = collectionView
        setUpSearchMenu()
        setTitle("Content")
    }

    private func setUpSearchMenu() {
        let searchImage = UIImage(named: "search")
        let menuSearch = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(tapMenuSearch(sender:)))
        appBarViewController.navigationBar.rightBarButtonItem = menuSearch
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataSource.snapshot().itemIdentifiers[indexPath.row]
        if let content = model.value {
            let vc = ContentDetailViewController()
            vc.contentTitle = content.title
            vc.contentDate = content.date
            vc.contentBody = content.body
            vc.contentImages = content.contentImages
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.vm.resetPageConfiguration()
            self.loadData()
        }
    }

    private func disableRefreshControl() {
        if let refreshController = collectionView.refreshControl {
            if refreshController.isRefreshing {
                refreshController.endRefreshing()
            }
        }
    }

    @objc func tapMenuSearch(sender: Any) {
        navigationController?.pushViewController(ContentSearchViewController(), animated: true)
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func watchData() {
        vm.responses.subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] imageSets in
                self?.disableRefreshControl()
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
