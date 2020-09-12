//
//  ContactViewModel.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 12/09/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ContactViewModel: ListViewModel<ContactItem> {
    override func requestDataList() {
        ApiService.default.getContacts()
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { [weak self] response in
                self?.onDataListResult(response.getItems())
            }, onError: { [weak self] error in
                self?.onDataListError(error)
            }).disposed(by: disposeBag)
    }
}
