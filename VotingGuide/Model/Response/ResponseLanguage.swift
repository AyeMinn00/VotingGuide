//
//  ResponseLanguage.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

class Language: Codable, Hashable {
    let id: String
    let lang: String
    var isSelected = false

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case lang
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isSelected)
    }

    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Languages : Codable , List{
    
    var data: [Language] = []
    
    enum CodingKeys: String,  CodingKey {
        case data = "payload"
    }
    
    func isEmpty() -> Bool {
        return data.count == 0
    }
    
    func getItems() -> [LanguageItem] {
        var cells: [LanguageItem] = []
        for index in 0 ..< data.count {
            let lang = data[index]
            cells.append(LanguageItem(value: lang))
        }
        return cells
    }
    
}

class LanguageItem : CollectionItem {
    
    static func == (lhs: LanguageItem, rhs: LanguageItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
    
    var value : Language?
    var state : CellState
    
    required init(value: Language?) {
        self.value = value
        state = .main
    }
    
    required init(state: CellState) {
        self.state = state
        value = nil
    }
    
}
