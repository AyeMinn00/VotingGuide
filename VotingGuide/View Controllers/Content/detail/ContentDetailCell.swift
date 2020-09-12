//
//  ContentDetailCell.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 22/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit
import Kingfisher

class ContentDetailCell : UICollectionViewCell{
    
    static let name = "ContentDetailCell"
    
    var photo : UIImageView!
    
    let _photo : UIImageView = {
       let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 4
        photo.layer.borderWidth = 0.5
        photo.layer.borderColor = UIColor(named: "Grey_500")?.cgColor
        photo.backgroundColor = UIColor(named: "Grey_300")
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        photo = _photo
        addSubview(photo)
        photo.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        photo.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        photo.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchImage(_ url: String?) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: 512, height: 384))
        if url == nil {
            photo.image = UIImage(named: "sample1")
        } else {
            let url = URL(string: IMG_ORIGINAL_URL + url!)
            photo.kf.setImage(with: url, options: [
                .processor(processor),
                .cacheOriginalImage])
        }
    }
    
    func bind(_ str: String?){
        fetchImage(str)
    }
    
}
