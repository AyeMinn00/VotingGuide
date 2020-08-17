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
    weak var image: UIImageView!
    weak var line: UIView!

    private var imageSet: ImageSet?

    let _title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    let _image: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()

    let _line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        congfigTitle()
        configImage()
        configLine()
        configConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func congfigTitle() {
        title = _title
        addSubview(title)
    }

    private func configImage() {
        image = _image
        addSubview(image)
    }

    private func configLine() {
        line = _line
        addSubview(line)
    }

    private func configConstraint() {
        var viewDict = [String: Any]()
        viewDict["title"] = title
        viewDict["image"] = image
        viewDict["line"] = line

        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[title]-16-|", options: [], metrics: nil, views: viewDict)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[image]-16-|", options: [], metrics: nil, views: viewDict)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[line]-16-|", options: [], metrics: nil, views: viewDict)
        constraints += [image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 0.75),
                        line.heightAnchor.constraint(equalToConstant: 2)]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[title]-8-[image]-8-[line]-16-|", options: [], metrics: nil, views: viewDict)
        NSLayoutConstraint.activate(constraints)
    }

    func bind(_ imageSet: ImageSet?) {
        if let imageSet = imageSet {
            title.text = imageSet.title

            if imageSet.images.count > 0 {
                fetchImage(imageSet.images[0])
            }
        }
    }

    private func fetchImage(_ url: String?) {
        if let myUrl = url {
            let url = URL(string: IMG_ORIGINAL_URL + myUrl)
//            let processor = DownsamplingImageProcessor(size: CGSize(width: 256, height: 192))
            image.kf.setImage(with: url, options: [
                .cacheOriginalImage])
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageSet = nil
    }
}
