//
//  MenuViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 28/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import MaterialComponents.MaterialRipple
import UIKit

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
        labelContact.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(contactTapped(_:))))
        view.addSubview(labelContact)
        NSLayoutConstraint.activate([
            labelContact.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            labelContact.widthAnchor.constraint(equalTo: view.widthAnchor),
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
        labelSettings.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:))))
        view.addSubview(labelSettings)
        NSLayoutConstraint.activate([
            labelSettings.topAnchor.constraint(equalTo: line2.bottomAnchor),
            labelSettings.widthAnchor.constraint(equalTo: view.widthAnchor),
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

    private func createLabel(_ str: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let rippleView = MDCRippleView()
        rippleView.frame = view.bounds
        rippleView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rippleView.rippleColor = .lightGray
        view.addSubview(rippleView)
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalTo: view.heightAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        label.textColor = UIColor(named: "Grey_800")
        label.text = str
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return view
    }

    private func createLine() -> UIView {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(named: "Grey_100")
        return line
    }

    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }

    @objc func contactTapped(_ sender: UITapGestureRecognizer) {
        navigationController?.pushViewController(ContactViewController(), animated: true)
    }
}
