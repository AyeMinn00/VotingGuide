//
//  ContentViewModel.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 17/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import RxSwift

class ContentViewModel: InfiniteListViewModel<ContentItem>, InfiniteListViewModelDelegate {
    override init() {
        super.init()
        requestDelegate = self
    }

    func requestDataList() {
        ApiService.default.getAllContents(page: paging.currentPage)
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { [weak self] response in
                self?.onDataListResult(response.getItems())
            }, onError: { [weak self] error in
                self?.onDataListError(error)
            }).disposed(by: disposeBag)
    }
}
