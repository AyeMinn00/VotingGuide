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
    var moreThanTwoImages = false

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
        debugPrint("id is \(id)")
        for image in images {
            debugPrint("img name is \(image)")
        }
    }

    func format() {
        images.append("2020_08_12_9_38_50.png")
        images.append("2020_08_12_9_38_50.png")
        let count = images.count
        print("format count is \(count)")
        if count == 0 { return }
        if count > 0 {
            print("check 1")
            for index in 0...count-1{
                print("check 1 append \(index)")
                displayImages.append(images[index])
            }
        }
        if count >= 2 {
            print("check 2")
            moreThanTwoImages = true 
            let left = count - 2
            if left > 1 {
                leftImageCount = "+\(count - 2) images"
            } else {
                leftImageCount = "+\(count - 2) image"
            }
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
