//
//  LanguageSelectionViewModel.swift
//  VotingGuide
//
//  Created by Ko Ko Aye  on 28/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LanguageSelectionViewModel : ListViewModel<LanguageItem> {
    
    override func requestDataList() {
        ApiService.default.getLanguages()
        .observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .subscribe(onNext: { [weak self] response in
            self?.onDataListResult(response.getItems())
        }, onError: { [weak self] error in
            self?.onDataListError(error)
        }).disposed(by: disposeBag)
    }
    
}

