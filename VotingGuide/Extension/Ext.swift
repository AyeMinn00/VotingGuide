//
//  Ext.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 07/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

extension UITabBarItem{
    
    func configNameAndImage(title : String, named : String){
//        self.title = title
        image = UIImage(named: named)
//        imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
}

extension NSObject{
    
    func log(msg : String){
        let target = String(describing: self)
        debugPrint("\(target) ==> \(msg)")
    }
}
