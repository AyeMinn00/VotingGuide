//
//  Content.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 17/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

class Content: Codable, Hashable {
    let id: String?
    var title: String?
    var contentImages: [String?]
    let body: String?
    let langId: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case contentImages = "images"
        case body
        case langId = "lang"
        case date = "created_at"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Content, rhs: Content) -> Bool {
        return lhs.id == rhs.id
    }
}

// for parsing
struct Contents2: Codable {
    var contents: [Content]
}

struct Contents: Codable {
    var payload: Contents2

    func isEmpty() -> Bool {
        return payload.contents.count == 0
    }

    func getItems() -> [ContentItem] {
        var cells: [ContentItem] = []
        for index in 0 ..< payload.contents.count {
            let imageSet = payload.contents[index]
            imageSet.contentImages.append("2020_08_09_5_06_22.jpeg")
            imageSet.contentImages.append("2020_08_09_5_09_45.jpeg")
//            if index % 2 != 0 {
//                imageSet.title! = "This is title trailing and number of 3 lines."
//            } else {
//                imageSet.title! = "သီဟိုဠ်မှ ဉာဏ်ကြီးရှင်သည် "
//            }
            cells.append(ContentItem(value: imageSet))
        }
        return cells
    }
}

struct ContentItem: CollectionItem {
    var value: Content?
    var state: CellState

    init(value: Content?) {
        self.value = value
        state = .main
    }

    init(state: CellState) {
        self.state = state
        value = nil
    }
}
