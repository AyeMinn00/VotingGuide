//
//  ErrorCell.swift
//  MyanmarTalentStrategy
//
//  Created by Ko Ko Aye  on 09/07/2020.
//  Copyright © 2020 Ko Ko Aye . All rights reserved.
//

import MaterialComponents.MaterialButtons
import UIKit

protocol ErrorCellClickable: class {
    func didTapRetryButton()
}

class ErrorCell: UICollectionViewCell {
    static let name = "errorCell"

    weak var errorCellClickable: ErrorCellClickable?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.isUserInteractionEnabled = false
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .normal)
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 4
        button.setElevation(ShadowElevation(rawValue: 1), for: .normal)
        button.setElevation(ShadowElevation(rawValue: 2), for: .highlighted)
        button.setBackgroundColor(UIColor(named: "Grey_700"))
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        addSubview(button)
        let constraints = [
            button.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTap() {
        errorCellClickable?.didTapRetryButton()
    }

    deinit {
        errorCellClickable = nil
    }
}
