//
//  ContactViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 12/09/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialAppBar
import RxSwift
import UIKit

class ContactViewController: VotingGuideViewController, UICollectionViewDelegate, ErrorCellClickable {
    var appBarViewController: MDCAppBarViewController!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ContactItem>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, ContactItem>()

    let vm = ContactViewModel()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Contact Information"
        configViews()
        watchData()
        getContacts()
    }

    private func getContacts() {
        vm.loadData()
    }

    private func configViews() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action:
            #selector(handleRefreshControl),
            for: .valueChanged)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        collectionView.delegate = self
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.name)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.name)
        collectionView.register(EndCell.self, forCellWithReuseIdentifier: EndCell.name)
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: ContactCell.name)
        makeDataSource()
    }

    private func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ContactItem>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.state {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCell.name, for: indexPath) as? ContactCell
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

    private func createCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func applySnapshot(items: [ContactItem], _ reload: Bool = false) {
        if reload {
            snapshot.reloadItems(items)
        } else {
            snapshot.deleteAllItems()
            snapshot.appendSections([.main])
            snapshot.appendItems(items)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func watchData() {
        vm.responses.subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] languages in
                self?.bind(languages)
            }).disposed(by: disposeBag)
    }

    private func bind(_ contacts: [ContactItem]) {
        disableRefreshControl()
        applySnapshot(items: contacts)
    }

    func didTapRetryButton() {
        vm.loadData()
    }

    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.getContacts()
        }
    }

    private func disableRefreshControl() {
        if let refreshController = collectionView.refreshControl {
            if refreshController.isRefreshing {
                refreshController.endRefreshing()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
