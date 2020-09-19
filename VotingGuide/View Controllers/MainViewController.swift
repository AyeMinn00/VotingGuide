//
//  MainViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 11/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialBottomNavigation
import UIKit

class MainViewController: VotingGuideViewController, UIScrollViewDelegate {
    weak var bottomNavBar: MDCBottomNavigationBar!
    weak var containerView: UIView!
    weak var line : UIView!

    let bar: MDCBottomNavigationBar = {
        let bar = MDCBottomNavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor(named: "color_primary")
        bar.elevation = ShadowElevation(.zero)
        bar.titleVisibility = .selected
        bar.alignment = .centered
        return bar
    }()

    /*
     container view , selected view will be added to this container
     */
    let _containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        return view
    }()

    let _line: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(named: "Grey_400")
        return line
    }()

    let h = ContentViewController()
    let g = GalleryViewController()
    let s = MenuViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "color_primary")
        title = "Home"
        configBottomNavBar()
        configTabBarToBottomNavigation()
        configContainerView()
        initHomeViewController()
    }

    private func configBottomNavBar() {
        bottomNavBar = bar
        view.addSubview(bottomNavBar)
        bottomNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomNavBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomNavBar.delegate = self
        line = _line
        view.addSubview(line)
        line.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: bottomNavBar.topAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    private func configContainerView() {
        containerView = _containerView
        view.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: line.topAnchor).isActive = true
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
        bottomNavBar.selectedItemTintColor = UIColor(named: "color_accent")!
        
        
        bottomNavBar.selectedItem = homeTabBar
    }

    private func initHomeViewController() {
        add(h, containerView: containerView)
    }
}

extension MainViewController: MDCBottomNavigationBarDelegate {
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            title = "Home"
            g.remove()
            s.remove()
            add(h, containerView: containerView)
        case 1:
            title = "Gallery"
            h.remove()
            s.remove()
            add(g, containerView: containerView)
        case 2:
            title = "Settings"
            h.remove()
            g.remove()
            add(s, containerView: containerView)
        default:
            title = "Home"
        }
    }
}
