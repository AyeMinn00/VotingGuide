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
    weak var line: UIView!
    weak var titleAndPhoto: UIStackView!

    let _titleAndPhoto: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .top
        view.distribution = .fill
        return view
    }()

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
        image.layer.cornerRadius = 4.0
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor(named: "Grey_100")?.cgColor
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor(named: "Grey_200")
        image.image = nil
        return image
    }()

    let _line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Grey_300")
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        isUserInteractionEnabled = true
        configUIViews()
        configConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUIViews() {
        title = _title
        photo = _photo
        titleAndPhoto = _titleAndPhoto
        titleAndPhoto.addArrangedSubview(title)
        titleAndPhoto.addArrangedSubview(photo)
        addSubview(_titleAndPhoto)
        date = _date
        imageCount = _imageCount
        line = _line
        addSubview(date)
        addSubview(imageCount)
        addSubview(line)
    }

    private func configConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            titleAndPhoto.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            titleAndPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleAndPhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            photo.widthAnchor.constraint(lessThanOrEqualToConstant: 130),
            photo.heightAnchor.constraint(equalTo: photo.widthAnchor, multiplier: 0.75),
            date.topAnchor.constraint(equalTo: titleAndPhoto.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            date.trailingAnchor.constraint(equalTo: photo.leadingAnchor, constant: 8),
            imageCount.topAnchor.constraint(equalTo: _titleAndPhoto.bottomAnchor, constant: 8),
            imageCount.leadingAnchor.constraint(equalTo: photo.leadingAnchor),
            imageCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            line.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 26),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func fetchImage(_ url: String?) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: 256, height: 192))
        if url == nil {
            photo.image = nil
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
            imageCount.text = content.leftImageCountLabel
            if content.contentImages.count > 0 {
                fetchImage(content.contentImages[0])
            }else {
                fetchImage(nil)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let p = photo{
            p.image = nil
        }
    }

}
