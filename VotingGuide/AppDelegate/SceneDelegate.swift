//
//  SceneDelegate.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 01/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialAppBar
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: UIScreen.main.bounds)

        if UserDefaultManager.shared.getSelectedLanguage() == nil {
            window?.rootViewController = LanguageSelectionViewController()
        } else {
            let rootViewController = MDCAppBarNavigationController(rootViewController: MainViewController())
            rootViewController.delegate = self
            window?.rootViewController = rootViewController
        }

        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate: MDCAppBarNavigationControllerDelegate {
    func appBarNavigationController(_ navigationController: MDCAppBarNavigationController, willAdd appBarViewController: MDCAppBarViewController, asChildOf viewController: UIViewController) {
        appBarViewController.headerView.backgroundColor = UIColor(named: "color_primary")
        appBarViewController.navigationBar.backgroundColor = UIColor(named: "color_primary")
        appBarViewController.navigationBar.titleTextColor = .black
        appBarViewController.navigationBar.titleAlignment = .leading
        let layer = CAGradientLayer()
        layer.colors = [UIColor(named: "Grey_200")!]
        appBarViewController.headerView.shadowLayer = layer
        appBarViewController.navigationBar.leadingBarItemsTintColor = UIColor(named: "color_accent")
        appBarViewController.navigationBar.titleFont = UIFont.systemFont(ofSize: 20)
        appBarViewController.headerView.shadowLayer = CAGradientLayer()
        appBarViewController.headerView.canOverExtend = false
        appBarViewController.headerView.visibleShadowOpacity = 0.2
    }
}
