//
//  LoadingCell.swift
//  MyanmarTalentStrategy
//
//  Created by Aye Min 00 on 4/29/20.
//  Copyright © 2020 Ko Ko Aye . All rights reserved.
//

import MaterialComponents.MaterialActivityIndicator
import UIKit

class LoadingCell: UICollectionViewCell {
    static let name = "loadingCell"

    weak var indicator: MDCActivityIndicator!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        isUserInteractionEnabled = false
        let loading = MDCActivityIndicator()
        loading.cycleColors = [.blue]
        loading.strokeWidth = 2
        loading.radius = 16.0
        loading.translatesAutoresizingMaskIntoConstraints = false
        indicator = loading
        indicator.startAnimating()
        addSubview(loading)

        NSLayoutConstraint.activate([
            loading.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            loading.centerXAnchor.constraint(equalTo: centerXAnchor),
            loading.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        indicator.stopAnimating()
    }
}
