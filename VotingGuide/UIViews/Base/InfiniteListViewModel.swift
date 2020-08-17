//
//  InfiniteListViewModel.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol InfiniteListViewModelDelegate: class {
    func requestDataList()
}

class InfiniteListViewModel<DataType: CollectionItem>: NSObject {
    
    weak var requestDelegate: InfiniteListViewModelDelegate!
    var paging = Paging.create()
    let disposeBag = DisposeBag()

    var isFirstRequest = true

    var dataSet: [DataType] = []
    
    let responses : PublishRelay<[DataType]> = PublishRelay()

    func setCurrentPage(page: Int) {
        paging.currentPage = page
    }

    func setPagingError(hasError: Bool) {
        paging.setError(hasError)
    }

    func setIsLoading(isLoading: Bool) {
        paging.setLoading(isLoading)
    }

    func isLoading() -> Bool {
        return paging.isLoading
    }

    func didFinish() -> Bool {
        return paging.finish
    }

    func loadData() {
        if isFirstRequest {
            isFirstRequest = false
            dataSet.append(DataType(state: .loading))
           updateDataSet()
        }

        if paging.shouldLoad() {
            if paging.hasError {
                if dataSet.count > 0 {
                    _ = dataSet.removeLast()
                    dataSet.append(DataType(state: .loading))
                    updateDataSet()
                }
            }
            paging.setLoading(true)
            requestDelegate.requestDataList()
        }
    }

    func onDataListResult(_ response: [DataType]) {
        // if last index of data set is not main data, we will remove last item

        if dataSet.count > 0 {
            if dataSet.last?.state != .main {
                _ = dataSet.removeLast()
            }
        }
        dataSet += response
        paging.increasePage()
        if response.isEmpty {
            paging.setFinish(true)
            dataSet.append(DataType(state: .finished))
        } else {
            dataSet.append(DataType(state: .loading)) // although data set last item is not in loading state , we have to set last item to loading state to show user
        }
        updateDataSet()
    }

    func onDataListError(_ error: Error) {
        paging.setError(true)
        if dataSet.count > 0 {
            if dataSet.last?.state != .main {
                _ = dataSet.removeLast()
            }
        }
        dataSet.append(DataType(state: .error))
        updateDataSet()
    }
    
    func updateDataSet(){
        responses.accept(dataSet)
    }
    
}
