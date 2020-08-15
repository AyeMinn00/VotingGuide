//
//  List.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation

protocol List {
    associatedtype T : CollectionItem
    associatedtype E
    
    var data : [E] { get set }
    func isEmpty() -> Bool
    func getItems() -> [T]
    
}

enum Section {
    case main
    case loading
    case finished
    case error
}

enum CellState {
    case main
    case loading
    case error
    case finished
}

protocol CollectionItem : Hashable{
    
    associatedtype T
    
    var value : T? { get set }
    var state : CellState{ get set }
    
    init(value : T?)
    init(state : CellState)
    
}
