//
//  Setting.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 04/09/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialAppBar
import RxSwift
import UIKit

class SettingViewController: VotingGuideViewController, UICollectionViewDelegate, ErrorCellClickable {
    var appBarViewController: MDCAppBarViewController!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, LanguageItem>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, LanguageItem>()

    let vm = LanguageSelectionViewModel()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Select Language"
        configViews()
        watchData()
        getLanguages()
    }

    private func getLanguages() {
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
        collectionView.register(LanguageCell2.self, forCellWithReuseIdentifier: LanguageCell2.name)
        makeDataSource()
    }

    private func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, LanguageItem>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.state {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LanguageCell2.name, for: indexPath) as? LanguageCell2
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

    private func applySnapshot(items: [LanguageItem], _ reload: Bool = false) {
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

    private func bind(_ languages: [LanguageItem]) {
        disableRefreshControl()
        let newDataSet = changeDataSet(languages)
        applySnapshot(items: newDataSet)
    }

    func didTapRetryButton() {
        vm.loadData()
    }

    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.getLanguages()
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
        let dataSet = dataSource.snapshot().itemIdentifiers
        let lang = dataSet[indexPath.row]
        if let language = lang.value {
            UserDefaultManager.shared.selectLanguage(lang: language.id)
            let newDataSet = changeDataSet(dataSet)
            applySnapshot(items: newDataSet, true)
        }
    }

    private func changeDataSet(_ items: [LanguageItem]) -> [LanguageItem] {
        let selectedLangId = UserDefaultManager.shared.getSelectedLanguage() ?? ""
        items.forEach { item in
            if let value = item.value {
                value.isSelected = value.id == selectedLangId
            }
        }
        return items
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
