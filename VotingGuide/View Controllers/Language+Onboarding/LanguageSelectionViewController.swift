//
//  LanguageSelectionViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye  on 27/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialAppBar
import RxSwift
import UIKit

class LanguageSelectionViewController: VotingGuideViewController, UICollectionViewDelegate, ErrorCellClickable, LanguageCellClickable {
    weak var message: UILabel!
    var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, LanguageItem>!
    let vm = LanguageSelectionViewModel(false)

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configViews()
        watchData()
        getLanguages()
    }

    private func configViews() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
        ])
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.name)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.name)
        collectionView.register(EndCell.self, forCellWithReuseIdentifier: EndCell.name)
        collectionView.register(LanguageCell.self, forCellWithReuseIdentifier: LanguageCell.name)
        makeDataSource()
    }

    private func makeDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, LanguageItem>(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item.state {
            case .main:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LanguageCell.name, for: indexPath) as? LanguageCell
                cell?.bind(item.value)
                cell?.languageCellClickable = self
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(66))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(66))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func getLanguages() {
        vm.loadData()
    }

    private func watchData() {
        vm.responses.subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] languages in
                self?.applySnapshot(items: languages)
            }).disposed(by: disposeBag)
    }

    private func bind(_ languages: [LanguageItem]) {
        applySnapshot(items: languages)
    }

    func didTapRetryButton() {
        vm.loadData()
    }

    func didTapLanguageCell(lang: Language?) {
        if let language = lang {
            UserDefaultManager.shared.selectLanguage(lang: language.id)
            let rootViewController = MDCAppBarNavigationController(rootViewController: MainViewController())
            rootViewController.delegate = self
            rootViewController.modalPresentationStyle = .fullScreen
            present(rootViewController, animated: true)
        }
    }

    private func applySnapshot(items: [LanguageItem], _ animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LanguageItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension LanguageSelectionViewController: MDCAppBarNavigationControllerDelegate {
    func appBarNavigationController(_ navigationController: MDCAppBarNavigationController, willAdd appBarViewController: MDCAppBarViewController, asChildOf viewController: UIViewController) {
        appBarViewController.headerView.backgroundColor = UIColor(named: "color_primary")
        appBarViewController.navigationBar.backgroundColor = UIColor(named: "color_primary")
        appBarViewController.navigationBar.titleTextColor = .black
        appBarViewController.navigationBar.titleAlignment = .leading
        let layer = CAGradientLayer()
        layer.colors = [UIColor(named: "Grey_200")!]
        appBarViewController.headerView.shadowLayer = layer
        appBarViewController.navigationBar.leadingBarItemsTintColor = .black
        appBarViewController.navigationBar.titleFont = UIFont.systemFont(ofSize: 20)
        appBarViewController.headerView.shadowLayer = CAGradientLayer()
        appBarViewController.headerView.canOverExtend = false
        appBarViewController.headerView.visibleShadowOpacity = 0.2
    }
}
