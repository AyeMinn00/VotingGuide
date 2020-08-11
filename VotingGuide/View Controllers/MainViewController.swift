//
//  MainViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 11/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialBottomNavigation
import UIKit

class MainViewController: UIViewController {
    weak var bottomNavBar: MDCBottomNavigationBar!
    let appBarViewController = MDCAppBarViewController()

    let bar: MDCBottomNavigationBar = {
        let bar = MDCBottomNavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.titleVisibility = .selected
        bar.alignment = .centered
        return bar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Home"
        configAppBarViewController()
        layoutBottomNavBar()
        configTabBarToBottomNavigation()
    }

    private func configAppBarViewController() {
        addChild(appBarViewController)
        view.addSubview(appBarViewController.view)
        appBarViewController.didMove(toParent: self)
        appBarViewController.navigationBar.title = "Home"
        appBarViewController.navigationBar.titleFont = UIFont.boldSystemFont(ofSize: 10)
        appBarViewController.navigationBar.titleTextColor = .black
        appBarViewController.navigationBar.titleAlignment = .leading
        appBarViewController.navigationBar.backgroundColor = .white
        appBarViewController.headerView.backgroundColor = .white
    }

    private func layoutBottomNavBar() {
        bottomNavBar = bar
        view.addSubview(bottomNavBar)
        bottomNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomNavBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomNavBar.delegate = self
    }

    private func configTabBarToBottomNavigation() {
        let homeTabBar = UITabBarItem()
        homeTabBar.tag = 0
        homeTabBar.configNameAndImage(title: "Home", named: "home")

        let galleryTabBar = UITabBarItem()
        galleryTabBar.tag = 1
        galleryTabBar.configNameAndImage(title: "Gallery", named: "gallery")

        let settingTabBar = UITabBarItem()
        settingTabBar.tag = 2
        settingTabBar.configNameAndImage(title: "Settings", named: "settings")

        bottomNavBar.items = [homeTabBar, galleryTabBar, settingTabBar]
        bottomNavBar.titleVisibility = .never
        bottomNavBar.selectedItem = homeTabBar
    }
}

extension MainViewController: MDCBottomNavigationBarDelegate {
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            title = "Home"
        case 1:
            title = "Gallery"
        case 2:
            title = "Settings"
        default:
            title = "Home"
        }
    }
}
