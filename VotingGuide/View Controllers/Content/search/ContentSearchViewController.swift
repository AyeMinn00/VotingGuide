//
//  ContentSearchViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 06/09/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialAppBar
import RxSwift
import UIKit

class ContentSearchViewController: VotingGuideViewController, UISearchBarDelegate, UICollectionViewDelegate {
    var collectionView: UICollectionView!
    var scrollView: UIScrollView?
    let disposeBag = DisposeBag()
    var offset = 200

    var dataSource: UICollectionViewDiffableDataSource<Section, ContentItem>!

    private let viewModel = ContentSearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSearchBar()
        setUpCollectionView()
    }

    private func setUpSearchBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barTintColor = UIColor(named: "Grey_200")
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.textColor = .black
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search Content..."
        navigationItem.hidesSearchBarWhenScrolling = false

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            searchBar.becomeFirstResponder()
        }
    }

    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
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
        collectionView.delegate = self
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.name)
        collectionView.register(ErrorCell.self, forCellWithReuseIdentifier: ErrorCell.name)
        collectionView.register(ContentCell.self, forCellWithReuseIdentifier: ContentCell.name)
        collectionView.register(EndCell.self, forCellWithReuseIdentifier: EndCell.name)
        makeDataSource()
    }

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
            loadData()
        }
    }

    private func loadData() {
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

    func applySnapshot(items: [ContentItem], _ animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ContentItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
        if !doesCollectionViewMeetFullScreen() {
            loadData()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.setSearchQuery(key: searchText)
    }
}

extension ContentSearchViewController: ErrorCellClickable {
    func didTapRetryButton() {
    }
}
