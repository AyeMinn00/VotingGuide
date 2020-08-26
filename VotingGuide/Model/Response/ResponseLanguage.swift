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

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case lang
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Language, rhs: Language) -> Bool {
        return lhs.id == rhs.id
    }
}
