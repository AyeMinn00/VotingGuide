//
//  ResponseImageSet.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

struct ImageSet: Codable, Hashable {
    
    let id: String
    let images: [String]
    let title: String
    let lang: Language

    enum CodingKeys: String, CodingKey {
        case images
        case id = "_id"
        case title
        case lang
    }

    static func == (lhs: ImageSet, rhs: ImageSet) -> Bool {
        return lhs.id == rhs.id
    }
    
    func display(){
        debugPrint("id is \(id)")
        for image in images{
            debugPrint("img name is \(image)")
        }
    }
}

struct ImageSets: Codable , List{
    var data: [ImageSet] = []

    enum CodingKeys: String, CodingKey {
        case data = "payload"
    }
    
    func isEmpty() -> Bool {
        return data.count == 0
    }
    
    func getItems() -> [ImageSetItem] {
        var cells : [ImageSetItem] =  []
        for index in 0 ..< data.count {
            let imageSet = data[index]
            cells.append(ImageSetItem(value: imageSet))
        }
        return cells
    }
}

struct ImageSetItem : CollectionItem{
    
    var value : ImageSet?
    var state : CellState
    
    init(value: ImageSet?) {
        self.value = value
        self.state = .main
    }
    
    init(state: CellState) {
        self.state = state
        self.value = nil 
    }
    
}

