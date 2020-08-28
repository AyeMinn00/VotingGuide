//
//  LanguageViewWithOr.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 27/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class LanguageViewWithOr : UIView{
    
    private weak var label : UILabel!
    private weak var orLabel : UIView!
    
    let _label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor(named: "Grey_800")
        return label
    }()
    
    let _orLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "or"
        label.textColor = UIColor(named: "Grey_300")
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    private func config(){
        label = _label
        orLabel = _orLabel
        addSubview(label)
        addSubview(orLabel)
        
    }
    
    func setText(_ text: String?){
        label.text = text
    }
    
    func activateConstraint(){
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            orLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            orLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            orLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            self.bottomAnchor.constraint(equalTo: orLabel.bottomAnchor)
        ])
    }
    
}

class LanguageView : UIView{
    
    private weak var label : UILabel!
    
    let _label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor(named: "Grey_800")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    private func config(){
        label = _label
        addSubview(label)
        
        
    }
    
    func activateConstraint(){
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            self.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
    }
    
    func setText(_ text: String?){
        label.text = text
    }
    
}
