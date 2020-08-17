//
//  Content.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 17/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

struct Content: Codable, Hashable {
    let id: String
    let title: String?
    let images: [String?]
    let body: String?
    let langId: String
    let date : String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case images
        case body
        case langId = "lang"
        case date = "created_at"
    }
}

// for parsing
struct Contents2 : Codable{
    var contents : [Content]
}

struct Contents: Codable {
    
    var payload : Contents2

    func isEmpty() -> Bool {
        return payload.contents.count == 0
    }

    func getItems() -> [ContentItem] {
        var cells: [ContentItem] = []
        for index in 0 ..< payload.contents.count {
            let imageSet = payload.contents[index]
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
