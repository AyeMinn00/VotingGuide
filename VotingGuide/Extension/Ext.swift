//
//  Ext.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 07/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

extension UITabBarItem{
    
    func configImage(named : String){
        title = ""
        image = UIImage(named: named)
        imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
}
