//
//  LanguageSelectionViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye  on 27/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit
import RxSwift

class LanguageSelectionViewController: VotingGuideViewController {
    
    weak var message: UILabel!
    weak var containerView: UIView!
    weak var scrollView: UIScrollView!
    
    let disposeBag = DisposeBag()

    let _message: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Grey_800")
        label.font = UIFont.systemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()

    let _containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let _sv: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.showsVerticalScrollIndicator = false 
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configViews()
        getLanguages()
    }

    private func configViews() {
        scrollView = _sv
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        containerView = _containerView
        scrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        message = _message
//        containerView.addSubview(message)
//        NSLayoutConstraint.activate([
//            message.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 46),
//            message.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
//        ])
       
    }

    private func getLanguages(){
        ApiService.default.getLanguages()
        .observeOn(MainScheduler.instance)
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { [weak self](languages) in
                self?.bind(languages.payload)
            }, onError: { (error) in
                
            }).disposed(by: disposeBag)
    }
    
    private func bind(_ languages : [Language]) {
        var views : [UIView] = []
        if languages.count == 0 { return }
        let last = languages.count-1
        for index in 0...languages.count-1{
            let lang = languages[index]
            if index == last {
                let view = UILabel()
//                view.setText(lang.lang)
                view.text = lang.lang
                views.append(view)
                containerView.addSubview(view)
                log(msg: "add to container at last")
            }else {
                let view = UILabel()
//                view.setText(lang.lang)
                view.text = lang.lang
                views.append(view)
                containerView.addSubview(view)
                log(msg: "add to container")
            }
        }
        log(msg: "views \(views.count)")
        for index in 0...views.count-1{
            let view = views[index]
            if index == 0 {
                view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            }else {
                view.topAnchor.constraint(equalTo: views[index-1].bottomAnchor, constant: 8).isActive = true
            }

            view.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1.0).isActive = true
//            if let v = view as? LanguageView{
//                v.activateConstraint()
//            }
//            if let v = view as? LanguageViewWithOr{
//                v.activateConstraint()
//            }
        }
//        containerView.bottomAnchor.constraint(equalTo: views[views.count-1].bottomAnchor, constant: 16).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        setScrollViewContentSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
        setScrollViewContentSize()
    }
    
    private func setScrollViewContentSize(){
//        containerView.bottomAnchor.constraint(equalTo: message.bottomAnchor, constant: 26).isActive = true
        containerView.layoutIfNeeded()
        let width = containerView.bounds.width
        let height = containerView.bounds.height
        print("width is \(width) and height is \(height)")
        scrollView.contentSize = CGSize(width: width, height: height)
//        scrollView.contentInsetAdjustmentBehavior = .never
    }
}
