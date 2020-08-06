//
//  ViewController.swift
//  VotingGuide
//
//  Created by Ko Ko Aye on 01/08/2020.
//  Copyright © 2020 Ko Ko Aye. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        title = "Home Vc"
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Home"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go Detail", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.backgroundColor = .systemGray6
        self.view.addSubview(button)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 64).isActive = true
        button.topAnchor.constraint(equalTo: label.topAnchor, constant: 64).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    @objc func tap(_ sender: Any){
        navigationController?.pushViewController(HomeViewDetailController(), animated: true)
    }
}

class HomeViewDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Home Detail"
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "Home Detail"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
}



class GalleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        title = "Gallery"
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Gallery"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }


}

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        title = "Setting"
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Setting"
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }


}
