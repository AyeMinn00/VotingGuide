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

class ContentSearchViewModel: NSObject {
    var isFirstRequest = true
    var paging = Paging.create()
    var dataSet: [ContentItem] = []
    let responses: PublishRelay<[ContentItem]> = PublishRelay()
    private var disposeBag = DisposeBag()
    private var disposable: Disposable?
    private var searchQueryRelay: PublishRelay<String> = PublishRelay()
    private var searchQuery: String = ""

    func setSearchQuery(key: String) {
        searchQueryRelay.accept(key)
    }

    override init() {
        super.init()
        searchQueryRelay.debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] key in
                self?.resetPageConfiguration()
                self?.searchQuery = key
                self?.loadData()
            }).disposed(by: disposeBag)
    }

    func loadData() {
        if searchQuery.isEmpty { return }
        if isFirstRequest {
            isFirstRequest = false
            dataSet.append(ContentItem(state: .loading))
            responses.accept(dataSet)
        }

        if paging.shouldLoad() {
            if paging.hasError {
                if dataSet.count > 0 {
                    _ = dataSet.removeLast()
                    dataSet.append(ContentItem(state: .loading))
                    responses.accept(dataSet)
                }
            }
            paging.setLoading(true)
            searchContent()
        }
    }

    func resetPageConfiguration() {
        paging = Paging.create()
        dataSet.removeAll()
        disposable?.dispose()
        isFirstRequest = true
    }

    private func searchContent() {
        if searchQuery.isEmpty { return }
        disposable = ApiService.default.searchContent(page: paging.currentPage, key: searchQuery)
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { [weak self] response in
                self?.onDataListResult(response.getItems())
            }, onError: { [weak self] error in
                self?.onDataListError(error)
            })
    }

    private func onDataListResult(_ response: [ContentItem]) {
        if dataSet.count > 0 {
            if dataSet.last?.state != .main {
                _ = dataSet.removeLast()
            }
        }
        dataSet += response
        paging.increasePage()
        if response.isEmpty {
            paging.setFinish(true)
        } else {
            dataSet.append(ContentItem(state: .loading))
        }
        responses.accept(dataSet)
    }

    private func onDataListError(_ error: Error) {
        paging.setError(true)
        if dataSet.count > 0 {
            if dataSet.last?.state != .main {
                _ = dataSet.removeLast()
            }
        }
        dataSet.append(ContentItem(state: .error))
        responses.accept(dataSet)
    }

    deinit {
        disposable?.dispose()
    }
}
