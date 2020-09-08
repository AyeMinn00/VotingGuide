//
//  ContentSearchViewModel.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 08/09/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ContentSearchViewModel {
    private var disposeBag = DisposeBag()
    private var disposable: Disposable?
    private var searchQuery: PublishRelay<String> = PublishRelay()

    func setSearchQuery(key: String) {
        searchQuery.accept(key)
    }

    init() {
        searchQuery.debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] key in
                self?.searchContent(key: key)
            }).disposed(by: disposeBag)
    }

    private func searchContent(key: String) {
        disposable?.dispose()
        disposable = ApiService.default.searchContent(page: 0, key: key)
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { _ in
//                print("onNext")
            }, onError: { _ in
//                print("onError")
            }, onCompleted: {
//                print("onCompleted")
            }, onDisposed: {
//                print("onDisposed")
            })
    }
}
