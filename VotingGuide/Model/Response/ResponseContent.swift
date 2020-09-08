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
    var leftImageCountLabel = ""

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case contentImages = "images"
        case body
        case langId = "lang"
        case date = "time"
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
            if imageSet.contentImages.count > 1 {
                imageSet.leftImageCountLabel = "+\(imageSet.contentImages.count - 1) more"
            }
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
