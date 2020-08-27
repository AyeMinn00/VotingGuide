//
//  LanguageSelectionViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye  on 27/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class LanguageSelectionViewController: VotingGuideViewController {
    weak var message: UILabel!
    weak var containerView: UIView!
    weak var scrollView: UIScrollView!

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
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configViews()
        bind()
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
            containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        message = _message
        containerView.addSubview(message)
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            message.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
        ])
       
    }

    private func bind() {
        message.text = "Select Your language to use bar nadlfkasjd;lf ka;dfkj aoskdja osidfjpaosdifj dfj; When you set values like that, they become permanent – you can quit the app then re-launch and they'll still be there, so it's the ideal way to store app configuration data. As an advance warning, you might find some old tutorials recommend calling the synchronize() method to force your data to save, but Apple has asked us not to do that for some years now."
        setScrollViewContentSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
        setScrollViewContentSize()
    }
    
    private func setScrollViewContentSize(){
        containerView.bottomAnchor.constraint(equalTo: message.bottomAnchor, constant: 16).isActive = true
        containerView.layoutIfNeeded()
        let width = containerView.bounds.width
        let height = containerView.bounds.height
        print("width is \(width) and height is \(height)")
        scrollView.contentSize = CGSize(width: width, height: height)
//        scrollView.contentInsetAdjustmentBehavior = .never
    }
}
