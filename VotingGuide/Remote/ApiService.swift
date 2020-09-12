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
    private let userDefault = UserDefaultManager.shared

    func getAllImageSets() -> Observable<ImageSets> {
        let lang = userDefault.getSelectedLanguage() ?? ""
        let dataRequest = BaseRequest(path: "kaungrwai/imgSet/lang/\(lang)").create()
        return requestManager.request(dataRequest)
    }

    func getAllContents(page: Int) -> Observable<Contents> {
        let lang = userDefault.getSelectedLanguage() ?? ""
        let queries = createContentRequest(page: "\(page)", count: "10", langId: lang)
        let dataRequest = BaseRequest(path: "kaungrwai/content", query: queries).create()
        return requestManager.request(dataRequest)
    }

    func searchContent(page: Int, key: String) -> Observable<Contents> {
        let lang = userDefault.getSelectedLanguage() ?? ""
        let queries = createContentSearchRequest(page: "\(page)", limit: "10", key: key, lang: lang)
        let dataRequest = BaseRequest(path: "kaungrwai/content/search", query: queries).create()
        return requestManager.request(dataRequest)
    }

    func getLanguages() -> Observable<Languages> {
        let dataRequest = BaseRequest(path: "kaungrwai/language").create()
        return requestManager.request(dataRequest)
    }

    func getContacts() -> Observable<Contacts> {
        let dataRequest = BaseRequest(path: "kaungrwai/contact").create()
        return requestManager.request(dataRequest)
    }
}
