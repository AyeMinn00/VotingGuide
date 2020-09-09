//
//  EndCell.swift
//  MyanmarTalentStrategy
//
//  Created by Aye Min 00 on 5/2/20.
//  Copyright © 2020 Ko Ko Aye . All rights reserved.
//

import UIKit

class EndCell: UICollectionViewCell {
    static let name = "endCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false 
        backgroundColor = .white
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(named: "Grey_300")
        line.layer.cornerRadius = 2
        addSubview(line)
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            line.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            line.centerXAnchor.constraint(equalTo: centerXAnchor),
            line.heightAnchor.constraint(equalToConstant: 4),
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
