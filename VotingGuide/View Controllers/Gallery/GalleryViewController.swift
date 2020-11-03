//
//  HomeViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import RxSwift
import UIKit

class GalleryViewController: BaseChildViewController, UICollectionViewDelegate {
    private weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, ImageSetItem>!
    private let vm = GalleryViewModel()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        configAppBarViewController()
        appBarViewController.headerView.trackingScrollView = collectionView
        setTitle("Gallery")
        watchData()
        loadData()
    }

    private func setUpCollectionView() {
        initCollectionView()
        configCollectionView()
        makeDataSource()
    }

    private func initCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action:
            #selector(handleRefreshControl),
            for: .valueChanged)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        self.collectionView = collectionView
        self.collectionView.delegate = self
    }

    private func configCollectionView() {
        // register loading cell as footer in collection view
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.name)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.name)
        collectionView.register(EndCell.self, forCellWithReuseIdentifier: EndCell.name)
        collectionView.register(ImageSetCell.self, forCellWithReuseIdentifier: ImageSetCell.name)
    }

    private func createCollectionLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(500))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)

        let group = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func makeDataSource() {
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

    private func loadData() {
        vm.loadData()
    }

    private func applySnapshot(items: [ImageSetItem], _ animatingDifferences: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageSetItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func watchData() {
        vm.responses.subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] imageSets in
                self?.disableRefreshControl()
                self?.applySnapshot(items: imageSets)
            }).disposed(by: disposeBag)
    }

    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
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
}

// Mark
extension GalleryViewController: ErrorCellClickable {
    func didTapRetryButton() {
        loadData()
    }
}

extension GalleryViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataSource.snapshot().itemIdentifiers[indexPath.row]
        DispatchQueue.main.async {
            if let content = model.value {
                let vc = PhotoViewController()
                vc.contentImages = content.images
                vc.selectedIndex = indexPath.row
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
