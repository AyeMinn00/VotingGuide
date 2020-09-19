//
//  LanguageCell.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 04/09/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class LanguageCell2 : UICollectionViewCell{
    
    static let name = "LanguageCell2"
    
    private weak var label : UILabel!
    private weak var line : UIView!
    private weak var imageView : UIImageView!
    private var lang: Language?
    
    let _label : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    let _imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "correct")?.withRenderingMode(.alwaysTemplate)
        imgView.tintColor = UIColor(named: "color_accent")
        return imgView
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
        line = _line
        imageView = _imgView
        addSubview(label)
        addSubview(line)
        addSubview(imageView)
        imageView.isHidden = true
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 22),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            imageView.heightAnchor.constraint(equalToConstant: 22),
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 18),
            label.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 22),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8),
            line.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 18),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func bind(_ lang : Language?){
        self.lang = lang
        label.text = self.lang?.lang
        imageView.isHidden = !(self.lang?.isSelected ?? false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lang = nil
    }
    
}
