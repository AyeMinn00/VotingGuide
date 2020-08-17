//
//  BaseRequest.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Alamofire
import Foundation

struct BaseRequest: URLRequestConvertible {
    fileprivate let baseURL = URL(string: BASE_URL)!
    let encoder = JSONParameterEncoder.default
    let method: HTTPMethod
    let path: String
    let query: [String: String]

    init(path: String, query: [String: String] = [:], method: HTTPMethod = .get) {
        self.path = path
        self.query = query
        self.method = method
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Base url cannot be resolved")
        }

        if query.count > 0 {
            var queryItems = [URLQueryItem]()
            for item in query {
                queryItems.append(URLQueryItem(name: item.key, value: item.value))
            }
            components.queryItems = queryItems
        }

        guard let queriedURL = components.url else {
            fatalError("URL cannot be constructed from URL components!")
        }

        var request = URLRequest(url: queriedURL)
        request.httpMethod = method.rawValue
        return request
    }

    func create() -> DataRequest {
        return AF.request(self)
    }
}
