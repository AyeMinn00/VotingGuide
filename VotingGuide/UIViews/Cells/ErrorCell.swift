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

    weak var errorCellClickable: ErrorCellClickable? {
        didSet {
            log(msg: "set error cell clickable")
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        contentView.isUserInteractionEnabled = false
        let button = MDCButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .normal)
        button.isUserInteractionEnabled = true
        button.setElevation(ShadowElevation(rawValue: 2), for: .normal)
        button.setElevation(ShadowElevation(rawValue: 4), for: .highlighted)
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        addSubview(button)
        let constraints = [button.widthAnchor.constraint(equalToConstant: 120), button.heightAnchor.constraint(equalToConstant: 48),
                           button.centerYAnchor.constraint(equalTo: self.centerYAnchor), button.centerXAnchor.constraint(equalTo: self.centerXAnchor)]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTap() {
        log(msg: "didTap")
        errorCellClickable?.didTapRetryButton()
    }

    deinit {
        errorCellClickable = nil
    }
}
