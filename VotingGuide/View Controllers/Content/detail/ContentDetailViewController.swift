//
//  ContentDetailViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 21/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class ContentDetailViewController: VotingGuideViewController , UICollectionViewDelegate{
    weak var scrollView: UIScrollView!
    weak var contentView: UIView!
    weak var titleLabel: UILabel!
    weak var dateLabel: UILabel!
    var collectionView: UICollectionView!
    weak var bodyLabel: UILabel!
    
    private var dataSource : UICollectionViewDiffableDataSource<Section, String?>!

    var contentTitle: String?
    var contentDate: String?
    var contentBody: String?
    var contentImages : [String?]?

    let _sv: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

    let _container: UIView = {
        let c = UIView()
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    let _title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = UIColor(named: "Grey_800")
        return label
    }()

    let _date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.textColor = UIColor(named: "Grey_600")
        return label
    }()

    let _body: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "Grey_700")
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Content Detail"
        view.backgroundColor = .white
        scrollView = _sv
        view.addSubview(scrollView)

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        contentView = _container
        scrollView.addSubview(contentView)

        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true

        titleLabel = _title
        dateLabel = _date
        bodyLabel = _body
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white

        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(bodyLabel)

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true
        bodyLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true

        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        bodyLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36).isActive = true
        
        configCollectionView()

        bind()
    }

    private func bind() {
        titleLabel.text = contentTitle
        dateLabel.text = contentDate
        bodyLabel.text = contentBody
        if let images = contentImages{
            applySnapshot(items: images)
        }
    }
    
    private func configCollectionView(){
        collectionView.register(ContentDetailCell.self, forCellWithReuseIdentifier: ContentDetailCell.name)
        makeDataSource()
    }
    
    private func makeDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,String?>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, str) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentDetailCell.name, for: indexPath) as? ContentDetailCell
            cell?.bind(str)
            return cell
        })
    }
    
    private func createCollectionLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2.0, leading: 2.0, bottom: 2.0, trailing: 2.0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func applySnapshot(items: [String?], _ animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String?>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = contentView.bounds.width
        let height = contentView.bounds.height
        scrollView.contentSize = CGSize(width: width, height: height)
        scrollView.contentInsetAdjustmentBehavior = .never
    }
}
