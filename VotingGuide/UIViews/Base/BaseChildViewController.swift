//
//  BaseChildViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 19/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialTypography

class BaseChildViewController : VotingGuideViewController{
    
    let appBarViewController = MDCAppBarViewController()
    
    func configAppBarViewController() {
        addChild(appBarViewController)
        view.addSubview(appBarViewController.view)
        appBarViewController.didMove(toParent: self)
        appBarViewController.navigationBar.allowAnyTitleFontSize = true
        appBarViewController.navigationBar.titleFont = MDCTypography.boldFont(from: UIFont.systemFont(ofSize: 24))
        appBarViewController.navigationBar.titleTextColor = .black
        appBarViewController.showsHairline = true
        let layer = CAGradientLayer()
        appBarViewController.headerView.shadowLayer = layer
        appBarViewController.headerView.minMaxHeightIncludesSafeArea = false
        appBarViewController.hairlineColor = UIColor(named: "Grey_500")!
        appBarViewController.navigationBar.titleAlignment = .leading
        appBarViewController.navigationBar.backgroundColor = .white
        appBarViewController.headerView.backgroundColor = .white
    }
    
    func setTitle(_ title : String){
        appBarViewController.navigationBar.title = title
        
    }
    
}
