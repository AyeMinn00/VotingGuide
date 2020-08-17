//
//  LoadingCell.swift
//  MyanmarTalentStrategy
//
//  Created by Aye Min 00 on 4/29/20.
//  Copyright © 2020 Ko Ko Aye . All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator

class LoadingCell: UICollectionViewCell {
    static let name = "loadingCell"

    weak var indicator: MDCActivityIndicator!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        isUserInteractionEnabled = false
        let loading = MDCActivityIndicator()
        loading.cycleColors = [.blue]
        loading.strokeWidth = 2
        loading.radius = 16.0
        loading.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loading)

        var constraints = [NSLayoutConstraint]()

        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[loading]-16-|", options: [], metrics: nil, views: ["loading": loading] as [String: Any])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-50@500-[loading]-50@500-|", options: [], metrics: nil, views: ["loading": loading] as [String: Any])

        NSLayoutConstraint.activate(constraints)

        indicator = loading
        indicator.startAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        indicator.stopAnimating()
    }
}
