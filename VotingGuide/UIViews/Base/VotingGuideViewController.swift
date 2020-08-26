//
//  VotingGuideViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class VotingGuideViewController: UIViewController {
    override func loadView() {
        super.loadView()
//        log(msg: "loadView()")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        log(msg: "viewDidLoad()")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        log(msg: "viewWillAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        log(msg: "viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        log(msg: "viewDidDisappear")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

//    override var additionalSafeAreaInsets: UIEdgeInsets{
//        set{
//
//        }
//        get{
//            return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
//        }
//    }
}
