//
//  LanguageCell.swift
//  VotingGuide
//
//  Created by Ko Ko Aye  on 28/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialButtons
import UIKit

protocol LanguageCellClickable: class {
    func didTapLanguageCell(lang: Language?)
}

class LanguageCell: UICollectionViewCell {
    static let name = "LanguageCell"

    weak var languageCellClickable: LanguageCellClickable?

    private weak var label: MDCButton!
    private var lang: Language?

    let _label: MDCButton = {
        let label = MDCButton()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.setElevation(ShadowElevation(rawValue: 1), for: .normal)
        label.setElevation(ShadowElevation(rawValue: 2), for: .highlighted)
        label.setBackgroundColor(UIColor(named: "Grey_500"))
        label.layer.cornerRadius = 8
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label = _label
        label.addTarget(self, action: #selector(didSelectLanguage), for: .touchUpInside)
        addSubview(label)
        label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 42).isActive = true
        label.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -42).isActive = true
    }

    func bind(_ language: Language?) {
        lang = language
        label.setTitle(lang?.lang, for: .normal)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        lang = nil
    }

    @objc func didSelectLanguage() {
        languageCellClickable?.didTapLanguageCell(lang: lang)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        languageCellClickable = nil
    }
}
