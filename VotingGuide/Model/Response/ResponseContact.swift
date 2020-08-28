//
//  ResponseContact.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 28/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

class Contact : Codable , Hashable{
    
    let id : String
    let title : String
    let description : String
    
    enum CodingKeys : String, CodingKey{
        case id = "_id"
        case title
        case description
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

struct Contacts : Codable , List {
    var data : [Contact]
    
    enum CodingKeys : String, CodingKey {
        case data = "payload"
    }
    
    func isEmpty() -> Bool {
        return data.count == 0
    }
    
    func getItems() -> [ContactItem] {
        var cells: [ContactItem] = []
        for index in 0 ..< data.count {
            let lang = data[index]
            cells.append(ContactItem(value: lang))
        }
        return cells
    }
    
}

struct ContactItem : CollectionItem{
    
    var value : Contact?
    var state : CellState
    
    init(value: Contact?) {
        self.value = value
        state = .main
    }
    
    init(state: CellState) {
        self.state = state
        value = nil
    }
    
    
}
