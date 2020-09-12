//
//  ContactCell.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 12/09/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class ContactCell: UICollectionViewCell {
    
    static let name = "ContactCell"
    
    private weak var title: UILabel!
    private weak var contactDescription: UILabel!
    private weak var line : UIView!

    private let _title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "Grey_500")
        label.numberOfLines = 2
        return label
    }()

    private let _description: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = UIColor(named: "Grey_800")
        return label
    }()
    
    let _line : UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(named: "Grey_200")
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        title = _title
        contactDescription = _description
        line = _line
        addSubview(title)
        addSubview(contactDescription)
        addSubview(line)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            contactDescription.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contactDescription.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contactDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            line.topAnchor.constraint(equalTo: contactDescription.bottomAnchor, constant: 16),
            line.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func bind(_ contact : Contact?){
        if let c = contact{
            title.text = c.title
            contactDescription.text = c.description
        }
    }
    
}
