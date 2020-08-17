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
        backgroundColor = .systemGray6
        let line = UIView()
        line.backgroundColor = .systemGray5
        line.translatesAutoresizingMaskIntoConstraints = false
        line.layer.cornerRadius = 2
        addSubview(line)
        
        var constraints = [NSLayoutConstraint]()

        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-84-[line]-84-|", options: [], metrics: nil, views: ["line": line] as [String: Any])
               constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-50@500-[line(4)]-50@500-|", options: [], metrics: nil, views: ["line": line] as [String: Any])

               NSLayoutConstraint.activate(constraints)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
