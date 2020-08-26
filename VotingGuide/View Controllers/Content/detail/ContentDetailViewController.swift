//
//  ContentDetailViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 21/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class ContentDetailViewController: VotingGuideViewController {
    weak var scrollView: UIScrollView!
    weak var contentView: UIView!
    weak var titleLabel: UILabel!
    weak var dateLabel: UILabel!
    weak var collectionView: UICollectionView!
    weak var bodyLabel: UILabel!

    var contentTitle: String?
    var contentDate: String?
    var contentBody: String?

    let _sv: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
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
        label.numberOfLines = 0
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
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        contentView = _container
        scrollView.addSubview(contentView)

        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 5 / 6).isActive = true

        titleLabel = _title
        dateLabel = _date
        bodyLabel = _body

        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(bodyLabel)

        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        bodyLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16).isActive = true

        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        bodyLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -36).isActive = true

        bind()
    }

    private func bind() {
        titleLabel.text = contentTitle
        dateLabel.text = contentDate
        bodyLabel.text = contentBody
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = contentView.bounds.width
        let height = contentView.bounds.height
        scrollView.contentSize = CGSize(width: width, height: height)
        scrollView.contentInsetAdjustmentBehavior = .never
    }
}
