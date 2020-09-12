//
//  ListViewModel.swift
//  VotingGuide
//
//  Created by Ko Ko Aye  on 28/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ListViewModel<DataType: CollectionItem>: NSObject {
    
    let disposeBag = DisposeBag()
    var dataSet: [DataType] = []
    let responses: PublishRelay<[DataType]> = PublishRelay()
    var hasFinishView : Bool = true
    
    init(_ hasFinishView : Bool = false) {
        self.hasFinishView = hasFinishView
    }

    func loadData() {
        dataSet.removeAll()
        dataSet.append(DataType(state: .loading))
        responses.accept(dataSet)
        requestDataList()
    }

    func onDataListResult(_ response: [DataType]) {
        dataSet.removeAll()
        dataSet += response
        if hasFinishView{
            dataSet.append(DataType(state: .finished))
        }
        responses.accept(dataSet)
    }

    func onDataListError(_ error: Error) {
        dataSet.removeAll()
        dataSet.append(DataType(state: .error))
        responses.accept(dataSet)
    }

    func requestDataList() {
    }
}
