//
//  ContentCell.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 17/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Kingfisher
import UIKit

class ContentCell: UICollectionViewCell {
    static let name = "ContentCell"

    static let titleFontSize = CGFloat(20)
    static let dateFontSize = CGFloat(12.0)
    static let imageCountFontSize = CGFloat(12.0)

    weak var title: UILabel!
    weak var date: UILabel!
    weak var imageCount: UILabel!
    weak var photo: UIImageView!
    weak var line : UIView!

    let _title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        label.textColor = UIColor(named: "Grey_800")
        return label
    }()

    let _date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: dateFontSize)
        label.textColor = UIColor(named: "Grey_500")
        return label
    }()

    let _imageCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: imageCountFontSize)
        label.textColor = UIColor(named: "Grey_400")
        return label
    }()

    let _photo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor(named: "Grey_200")
        return image
    }()

    let _line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Grey_300")
        view.layer.cornerRadius = 2
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUIViews()
        configConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUIViews() {
        title = _title
        photo = _photo
        date = _date
        imageCount = _imageCount
        line = _line
        addSubview(title)
        addSubview(photo)
        addSubview(date)
        addSubview(imageCount)
        addSubview(line)
    }

    private func configConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        constraints += [
            photo.widthAnchor.constraint(lessThanOrEqualToConstant: 160),
            photo.heightAnchor.constraint(equalTo: photo.widthAnchor, multiplier: 0.75),
            photo.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            photo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            title.topAnchor.constraint(equalTo: photo.topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: photo.leadingAnchor),
            title.bottomAnchor.constraint(equalTo: photo.bottomAnchor),
            date.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageCount.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 8),
            imageCount.leadingAnchor.constraint(equalTo: photo.leadingAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            line.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 26),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func fetchImage(_ url: String?) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: 256, height: 192))
        if url == nil {
            photo.image = UIImage(named: "sample1")
        } else {
            let url = URL(string: IMG_MEDIUM_URL + url!)
            photo.kf.setImage(with: url, options: [
                .processor(processor),
                .cacheOriginalImage])
        }
    }

    func bind(_ content: Content?) {
        if let content = content {
            title.text = content.title
            date.text = content.date
            imageCount.text = "+12 more"
            if content.images.count > 0 {
                fetchImage(content.images[0])
            }
        }
    }
}
