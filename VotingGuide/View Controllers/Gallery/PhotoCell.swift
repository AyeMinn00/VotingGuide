//
//  PhotoCell.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 30/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Kingfisher
import UIKit

class PhotoCell: UICollectionViewCell {
    static let name = "PhotoCell"

    weak var photo: UIImageView!

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false 
        return indicator
    }()

    let _photo: UIImageView = {
        let p = UIImageView()
        p.translatesAutoresizingMaskIntoConstraints = false
        p.clipsToBounds = true
        p.contentMode = .scaleAspectFill
        return p
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }

    private func config() {
        photo = _photo
        activityIndicator.startAnimating()
        addSubview(photo)
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            photo.centerYAnchor.constraint(equalTo: centerYAnchor),
            photo.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            photo.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 3 / 4),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 64),
            activityIndicator.widthAnchor.constraint(equalToConstant: 64)
        ])
    }

    func bind(_ str: String?) {
        fetchImage(str)
    }

    private func fetchImage(_ url: String?) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: 1024, height: 1024))
        if url == nil {
            photo.image = UIImage(named: "sample1")
            activityIndicator.stopAnimating()
        } else {
            let url = URL(string: IMG_MEDIUM_URL + url!)
            photo.kf.setImage(with: url, options: [
                .processor(processor),
                .cacheOriginalImage], completionHandler: { [weak self] _ in
                self?.activityIndicator.stopAnimating()
            })
        }
    }
}
