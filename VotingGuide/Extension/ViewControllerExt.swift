//
//  ViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 15/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func add(_ child: UIViewController, containerView : UIView){
        addChild(child)
        child.view.frame = containerView.bounds
        containerView.addSubview(child.view)
        child.didMove(toParent : self)
    }
    
    func remove(){
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        self.view.removeFromSuperview()
        removeFromParent()
    }
    
}
