//
//  RequestManager.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public enum NetworkError : Error{
    case unknown
    case connection(Error)
    case corruptedData
}

class RequestManager{
    
    public static let `default` = RequestManager()
    
    private init(){}
    
    func request<T : Codable>(_ dataRequest : DataRequest) -> Observable<T>{
        return Observable<T>.create { (observer) -> Disposable in
            let request = dataRequest.responseDecodable { (response : AFDataResponse<T>) in
                switch response.result{
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    debugPrint("request success \(dataRequest)")
                case .failure(let error):
                    debugPrint("request fail \(dataRequest) with Status Code \(response.response?.statusCode ?? -1)")
                    switch response.response?.statusCode {
                    case 0:
                        observer.onError(NetworkError.connection(error))
                    default:
//                        debugPrint("remote error \(error)")
                        observer.onError(NetworkError.unknown)
                    }
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
            
        }
    }
    
    
}














































