//
//  GalleryViewModel.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import RxSwift

class GalleryViewModel: InfiniteListViewModel<ImageSetItem>, InfiniteListViewModelDelegate {
    
    override init() {
        super.init()
        requestDelegate = self
    }

    func requestDataList() {
        log(msg: "requestDataList")
        ApiService.default.getAllImageSets()
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { [weak self] response in
                self?.onDataListResult(response.getItems())
            }, onError: { [weak self] error in
                self?.onDataListError(error)
            }).disposed(by: disposeBag)
    }
}
