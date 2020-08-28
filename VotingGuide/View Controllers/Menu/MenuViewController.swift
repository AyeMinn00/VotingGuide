//
//  MenuViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 28/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialRipple

class MenuViewController: BaseChildViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configAppBarViewController()
        setTitle("Menu")
        configViews()
    }

    private func configViews() {
        
        let itemHeight = CGFloat(50)
        let lineHeight = CGFloat(2)

        let labelContact = createLabel("Contact Information")
        view.addSubview(labelContact)
        NSLayoutConstraint.activate([
            labelContact.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 64),
            labelContact.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            labelContact.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelContact.heightAnchor.constraint(equalToConstant: itemHeight),
        ])

        let line2 = createLine()
        view.addSubview(line2)
        NSLayoutConstraint.activate([
            line2.heightAnchor.constraint(equalToConstant: lineHeight),
            line2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            line2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            line2.topAnchor.constraint(equalTo: labelContact.bottomAnchor),
        ])

        let labelSettings = createLabel("Settings")
        view.addSubview(labelSettings)
        NSLayoutConstraint.activate([
            labelSettings.topAnchor.constraint(equalTo: line2.bottomAnchor),
            labelSettings.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            labelSettings.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelSettings.heightAnchor.constraint(equalToConstant: itemHeight),
        ])

        let line3 = createLine()
        view.addSubview(line3)
        NSLayoutConstraint.activate([
            line3.heightAnchor.constraint(equalToConstant: lineHeight),
            line3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            line3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            line3.topAnchor.constraint(equalTo: labelSettings.bottomAnchor),
        ])
    }

    private func createLabel(_ str: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "Grey_800")
        label.text = str
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        let ripple = MDCRippleView()
        label.addSubview(ripple)
        return label
    }

    private func createLine() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(named: "Grey_100")
        return line
    }
}
