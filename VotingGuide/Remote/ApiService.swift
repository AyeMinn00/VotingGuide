//
//  ApiService.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

class ApiService {
    public static let `default` = ApiService()

    private let requestManager = RequestManager.default

    func getAllImageSets() -> Observable<ImageSets> {
        let dataRequest = BaseRequest(path: "kaungrwai/imgSet/lang/5f1935c27578a025f9175e65").create()
        return requestManager.request(dataRequest)
    }

    func getAllContents(page: Int) -> Observable<Contents> {
        let queries = createContentRequest(page: "\(page)", count: "10", langId: "5f1939a4c329f627d5d3d398")
        let dataRequest = BaseRequest(path: "kaungrwai/content", query: queries).create()
        return requestManager.request(dataRequest)
    }
    
    func getLanguages() -> Observable<Languages>{
        let dataRequest  = BaseRequest(path: "kaungrwai/language").create()
        return requestManager.request(dataRequest)
    }
}
