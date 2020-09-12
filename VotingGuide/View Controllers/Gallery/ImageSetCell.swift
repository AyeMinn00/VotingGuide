//
//  ImageSetCell.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Kingfisher
import UIKit

class ImageSetCell: UICollectionViewCell {
    static let name = "ImageSetCell"

    weak var title: UILabel!
    weak var containerView: UIView!
    weak var line: UIView!

    private var imageSet: ImageSet?
    let processor = DownsamplingImageProcessor(size: CGSize(width: 512, height: 384))

    let _stackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "Grey_200")?.cgColor
        return view
    }()

    let _title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 4
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = UIColor(named: "Grey_800")
        return title
    }()

    let _line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Grey_200")
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        title = _title
        addSubview(title)
        containerView = _stackView
        addSubview(containerView)
        line = _line
        addSubview(line)
        configConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configConstraint() {
        var constraints = [NSLayoutConstraint]()
        constraints += [
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.75),
            line.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 4),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func createImageView() -> UIImageView {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.layer.borderWidth = 2
        imgView.layer.cornerRadius = 4.0
        imgView.layer.borderColor = UIColor(named: "Grey_200")?.cgColor
        return imgView
    }

    func createLeftImageCountView(count: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "Grey_transparent")
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = count
        label.font = UIFont.systemFont(ofSize: 34)
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }

    func bind(_ imageSet: ImageSet?) {
        if imageSet == nil { return }
        title.text = imageSet!.title

        let count = imageSet!.displayImages.count
        
        if count == 1 {
            let img = createImageView()
            containerView.addSubview(img)
            img.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            img.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            img.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            img.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            let url = URL(string: IMG_MEDIUM_URL + imageSet!.displayImages[0])
            img.kf.setImage(with: url, options: [.cacheOriginalImage, .processor(processor)])
        }

        if count == 2 {
            let img1 = createImageView()
            let img2 = createImageView()
            containerView.addSubview(img1)
            containerView.addSubview(img2)
            img1.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            img1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            img1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            img1.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
            img2.topAnchor.constraint(equalTo: img1.bottomAnchor).isActive = true
            img2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            img2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            img2.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
            let url1 = URL(string: IMG_MEDIUM_URL + imageSet!.displayImages[0])
            img1.kf.setImage(with: url1, options: [.cacheOriginalImage,.processor(processor)])
            let url2 = URL(string: IMG_MEDIUM_URL + imageSet!.displayImages[1])
            img2.kf.setImage(with: url2, options: [.cacheOriginalImage, .processor(processor)])
        }

        if count > 2 {
            let img1 = createImageView()
            let img2 = createImageView()
            let img3 = createImageView()
            containerView.addSubview(img1)
            containerView.addSubview(img2)
            containerView.addSubview(img3)
            img1.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            img1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            img1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            img1.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
            img2.topAnchor.constraint(equalTo: img1.bottomAnchor).isActive = true
            img2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            img2.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5).isActive = true
            img2.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
            img3.topAnchor.constraint(equalTo: img1.bottomAnchor).isActive = true
            img3.leadingAnchor.constraint(equalTo: img2.trailingAnchor).isActive = true
            img3.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5).isActive = true
            img3.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
            let url1 = URL(string: IMG_MEDIUM_URL + imageSet!.displayImages[0])
            img1.kf.setImage(with: url1, options: [.cacheOriginalImage,.processor(processor)])
            let url2 = URL(string: IMG_MEDIUM_URL + imageSet!.displayImages[1])
            img2.kf.setImage(with: url2, options: [.cacheOriginalImage,.processor(processor)])
            let url3 = URL(string: IMG_MEDIUM_URL + imageSet!.displayImages[2])
            img3.kf.setImage(with: url3, options: [.cacheOriginalImage,.processor(processor)])

            if imageSet!.images.count > 3 {
                let leftImgCountView = createLeftImageCountView(count: imageSet!.leftImageCount)
                containerView.addSubview(leftImgCountView)
                NSLayoutConstraint.activate([
                    leftImgCountView.topAnchor.constraint(equalTo: img3.topAnchor),
                    leftImgCountView.bottomAnchor.constraint(equalTo: img3.bottomAnchor),
                    leftImgCountView.leadingAnchor.constraint(equalTo: img3.leadingAnchor),
                    leftImgCountView.trailingAnchor.constraint(equalTo: img3.trailingAnchor),
                ])

            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageSet = nil
    }
}
