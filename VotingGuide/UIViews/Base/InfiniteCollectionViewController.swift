//
//  InfiniteCollectionViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import RxSwift
import UIKit

class InfiniteCollectionViewController<ItemIdentifier>: BaseChildViewController, UICollectionViewDelegate where ItemIdentifier: CollectionItem {
    weak var infiniteListDelegate: InfiniteListDelegate?
    weak var collectionView: UICollectionView!
    weak var scrollView: UIScrollView?

    let disposeBag = DisposeBag()
    var offset = 200

    var dataSource: UICollectionViewDiffableDataSource<Section, ItemIdentifier>!

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    private func initCollectionView() {
        if let delegate = infiniteListDelegate {
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: delegate.createCollectionLayout())
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.automaticallyAdjustsScrollIndicatorInsets = false 
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
    }

    private func configCollectionView() {
        // register loading cell as footer in collection view
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.name)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.name)
        collectionView.register(EndCell.self, forCellWithReuseIdentifier: EndCell.name)

        // register for main cell
        if let delegate = infiniteListDelegate {
            delegate.registerCell()
        }
    }

    func setUpCollectionView() {
        initCollectionView()
        configCollectionView()
        if let delegate = infiniteListDelegate {
            offset = delegate.getOffSet()
            delegate.makeDataSource()
            delegate.watchData()
        }
    }

    func applySnapshot(items: [ItemIdentifier], _ animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemIdentifier>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        if !doesCollectionViewMeetFullScreen() {
            infiniteListDelegate?.loadData()
        }
    }

    // sometimes , collection view items does not meet phone screen full , so next request will never perform
    // this function is to check manually for list such as position list.
    private func doesCollectionViewMeetFullScreen() -> Bool {
        var result = true
        if let sv = scrollView {
            if sv.contentSize.height < sv.frame.size.height && sv.contentSize.height >= CGFloat(offset) {
                result = false
            }
        }
        return result
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge + CGFloat(offset) >= scrollView.contentSize.height {
            if let delegate = infiniteListDelegate {
                delegate.loadData()
            }
        }
    }

    // set public and override to let override subclass
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = UIColor(named: "Grey_200")
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = nil
        }
    }
}
