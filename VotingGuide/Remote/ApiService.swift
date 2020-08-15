//
//  ApiService.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class ApiService {
    public static let `default` = ApiService()

    private let requestManager = RequestManager.default
    
    func getAllImageSets() -> Observable<ImageSets>{
        debugPrint("getAllImageSets")
        let dataRequest = BaseRequest(path: "kaungrwai/imgSet/lang/5f1935c27578a025f9175e65").create()
        return requestManager.request(dataRequest)
    }
    
}
