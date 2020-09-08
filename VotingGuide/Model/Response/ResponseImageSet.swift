//
//  ResponseImageSet.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

class ImageSet: Codable, Hashable {
    let id: String
    var images: [String]
    var displayImages: [String] = []
    let title: String
    let lang: Language
    var leftImageCount: String = ""

    enum CodingKeys: String, CodingKey {
        case images
        case id = "_id"
        case title
        case lang
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ImageSet, rhs: ImageSet) -> Bool {
        return lhs.id == rhs.id
    }

    func display() {
        for image in images {
            debugPrint("img name is \(image)")
        }
    }

    func format() {
        let count = images.count
        if count == 0 { return }
        if count > 0 {
            var max = 3
            if count < 3{
                max = count
            }
            for index in 0...max-1{
                displayImages.append(images[index])
            }
        }
        if count > 3 {
            let left = count - 3
            leftImageCount = "+\(left)"
        }
    }
}

struct ImageSets: Codable, List {
    var data: [ImageSet] = []

    enum CodingKeys: String, CodingKey {
        case data = "payload"
    }

    func isEmpty() -> Bool {
        return data.count == 0
    }

    func getItems() -> [ImageSetItem] {
        var cells: [ImageSetItem] = []
        for index in 0 ..< data.count {
            let imageSet = data[index]
            imageSet.format()
            cells.append(ImageSetItem(value: imageSet))
        }
        return cells
    }
}

struct ImageSetItem: CollectionItem {
    var value: ImageSet?
    var state: CellState

    init(value: ImageSet?) {
        self.value = value
        state = .main
    }

    init(state: CellState) {
        self.state = state
        value = nil
    }
}
