//
//  GalleryViewModel.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GalleryViewModel : NSObject{
    
    let disposeBag = DisposeBag()
    var dataSet : [ImageSetItem]  = []
    let responses : PublishRelay<[ImageSetItem]> = PublishRelay()
    
    func loadData(){
        dataSet.append(ImageSetItem(state: .loading))
        responses.accept(dataSet)
        requestDataList()
    }
    
    private func onDataListResult(_ response: [ImageSetItem]){
        dataSet.removeAll()
        dataSet += response
        dataSet.append(ImageSetItem(state: .finished))
        self.responses.accept(dataSet)
    }
    
    private func onDataListError(_ error : Error){
        dataSet.removeAll()
        dataSet.append(ImageSetItem(state: .error))
        self.responses.accept(dataSet)
    }

    func requestDataList() {
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
