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
    var searchBar : UISearchBar!
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
        watchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchBar.becomeFirstResponder()
    }

    private func setUpSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barTintColor = UIColor(named: "Grey_200")
        searchBar.searchBarStyle = .minimal
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.textColor = .black
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search Content..."
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
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
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        self.view.addGestureRecognizer(tapGesture)
        makeDataSource()
    }

    private func doesCollectionViewMeetFullScreen() -> Bool {
        var result = true
        if collectionView.contentSize.height < collectionView.frame.size.height && collectionView.contentSize.height >= CGFloat(offset) {
            result = false 
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
        viewModel.loadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

    private func watchData() {
        viewModel.responses.subscribeOn(MainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] items in
                self?.applySnapshot(items: items)
            }).disposed(by: disposeBag)
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
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
    
}

extension ContentSearchViewController: ErrorCellClickable {
    func didTapRetryButton() {
        loadData()
    }
}

extension ContentSearchViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
