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

    static let titleFontSize = CGFloat(22)
    static let dateFontSize = CGFloat(12.0)
    static let imageCountFontSize = CGFloat(10.0)

    weak var title: UILabel!
    weak var date: UILabel!
    weak var imageCount: UILabel!
    weak var photo: UIImageView!
    weak var stackView: UIStackView!

    let _title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .systemGray
        return label
    }()

    let _date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: dateFontSize)
        label.textColor = .systemGray2
        return label
    }()

    let _imageCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: imageCountFontSize)
        label.textColor = .systemGray3
        return label
    }()

    let _photo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()

    let _stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .leading
        view.distribution = .fill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configStackView()
        configLabels()
        configConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configStackView() {
        title = _title
        photo = _photo
        configPhotoConstraint()
        stackView = _stackView
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(photo)
        addSubview(stackView)
    }

    private func configLabels() {
        date = _date
        imageCount = _imageCount
        addSubview(date)
        addSubview(imageCount)
    }

    private func configPhotoConstraint() {
        photo.widthAnchor.constraint(equalToConstant: 160).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }

    private func configConstraints() {
        var viewDict: [String: Any] = [:]
        viewDict["stackView"] = stackView
        viewDict["date"] = date
        viewDict["imageCount"] = imageCount

        var constraints = [NSLayoutConstraint]()
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[stackView]-16-|", options: [], metrics: nil, views: viewDict)
        constraints += [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            date.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            imageCount.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 4),
            imageCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            contentView.bottomAnchor.constraint(equalTo: date.bottomAnchor, constant: 16)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func fetchImage(_ url: String?) {
        let processor = DownsamplingImageProcessor(size: CGSize(width: 256, height: 256))
        if url == nil {
            photo.image = UIImage(named: "sample1")
        } else {
            let url = URL(string: IMG_MEDIUM_URL + url!)
            photo.kf.setImage(with: url, placeholder: UIImage(named: "sample1"), options: [
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
