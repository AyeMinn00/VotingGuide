//
//  Paging.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

struct Paging{
    var currentPage: Int
    var isLoading : Bool
    var hasError : Bool
    var finish : Bool
    
    static func create() -> Paging{
        return Paging(currentPage: 0, isLoading: false, hasError: false, finish: false)
    }
    
    func shouldLoad() -> Bool{
        return !isLoading && !finish
    }
    
    mutating func increasePage(){
        self.currentPage += 1
        self.isLoading = false
        self.hasError = false
    }
    
    mutating func setLoading(_ loading : Bool){
        isLoading = loading
        hasError = !loading
        finish = !loading
    }
    
    mutating func setError(_ hasError : Bool){
        self.hasError = hasError
        isLoading = !hasError
        finish = !hasError
    }
    
    mutating func setFinish(_ finish : Bool){
        self.finish = finish
        self.isLoading = !finish
        self.hasError = !finish
    }
    
}
