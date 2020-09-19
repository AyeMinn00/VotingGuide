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
        image = UIImage(named: named)
    }
    
}

extension NSObject{
    
    func log(msg : String){
        let target = String(describing: self)
        debugPrint("\(target) ==> \(msg)")
    }
}
