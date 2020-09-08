//
//  PhotoCell.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 30/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell : UICollectionViewCell{
    
    static let name = "PhotoCell"
    
    weak var photo : UIImageView!
    
    let _photo : UIImageView = {
        let p = UIImageView()
        p.translatesAutoresizingMaskIntoConstraints = false
//        p.clipsToBounds = false
//        p.contentMode = .scaleAspectFill
        return p
    }()
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder )
        config()
    }
    
    private func config(){
        photo = _photo
        addSubview(photo)
        NSLayoutConstraint.activate([
            photo.centerYAnchor.constraint(equalTo: centerYAnchor),
            photo.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            photo.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 3/4),
        ])
    }
    
    func bind(_ str : String?){
        fetchImage(str)
    }
    
    private func fetchImage(_ url: String?) {
//        let processor = DownsamplingImageProcessor(size: CGSize(width: 512, height: 384))
        if url == nil {
            photo.image = UIImage(named: "sample1")
        } else {
            let url = URL(string: IMG_MEDIUM_URL + url!)
            photo.kf.setImage(with: url, options: [
//                .processor(processor),
                .cacheOriginalImage])
        }
    }
    
}
