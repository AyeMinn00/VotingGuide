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
        sv.showsVerticalScrollIndicator = false 
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
            message.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 46),
            message.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
        ])
       
    }

    private func bind() {
        message.text = "Select Your language to use bar nadlfkasjd;lf ka;dfkj aoskdja osidfjpaosdifj dfj; When you set values like that, they become permanent – you can quit the app then re-launch and they'll still be there, so it's the ideal way to store app configuration data. As an advance warning, you might find some old tutorials recommend calling the synchronize() method to force your data to save, but Apple has asked us not to do that for some years now. The central notion of a UIScrollView object (or, simply, a scroll view) is that it is a view whose origin is adjustable over the content view. It clips the content to its frame, which generally (but not necessarily) coincides with that of the application’s main window. A scroll view tracks the movements of fingers and adjusts the origin accordingly. The view that is showing its content “through” the scroll view draws that portion of itself based on the new origin, which is pinned to an offset in the content view. The scroll view itself does no drawing except for displaying vertical and horizontal scroll indicators. The scroll view must know the size of the content view so it knows when to stop scrolling; by default, it “bounces” back when scrolling exceeds the bounds of the content.The object that manages the drawing of content displayed in a scroll view should tile the content’s subviews so that no view exceeds the size of the screen. As users scroll in the scroll view, this object should add and remove subviews as necessary.Because a scroll view has no scroll bars, it must know whether a touch signals an intent to scroll versus an intent to track a subview in the content. To make this determination, it temporarily intercepts a touch-down event by starting a timer and, before the timer fires, seeing if the touching finger makes any movement."
        setScrollViewContentSize()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
        setScrollViewContentSize()
    }
    
    private func setScrollViewContentSize(){
        containerView.bottomAnchor.constraint(equalTo: message.bottomAnchor, constant: 26).isActive = true
        containerView.layoutIfNeeded()
        let width = containerView.bounds.width
        let height = containerView.bounds.height
        print("width is \(width) and height is \(height)")
        scrollView.contentSize = CGSize(width: width, height: height)
//        scrollView.contentInsetAdjustmentBehavior = .never
    }
}
