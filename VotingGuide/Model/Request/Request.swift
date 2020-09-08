//
//  Request.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 17/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

func createContentRequest(page: String, count: String, langId: String) -> [String: String] {
    var queries: [String: String] = [:]
    queries["page"] = page
    queries["count"] = count
    queries["lang_id"] = langId
    return queries
}

func createContentSearchRequest(page: String, limit: String, key: String) -> [String: String] {
    var queries: [String: String] = [:]
    queries["page"] = page
    queries["limit"] = limit
    queries["key"] = key
    return queries
}
