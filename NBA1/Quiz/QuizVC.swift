//
//  QuizVC.swift
//  NBA1
//
//  Created by Погос  on 10.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit


class QuizVC: UIViewController {
    
    var imgImage: UIImageView?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Hall of Fame", image: UIImage(named: "Quiz"), tag: 3)
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
       
    let startedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(btnGetStartedAction), for: .touchUpInside)
        return button
    }()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hall of Fame"
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        imgImage = UIImageView(image: UIImage(named: "ball"))
        imgImage!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imgImage!)
        inputButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        animation()
    }
       
    func animation() {
        UIView.animate(withDuration: 1, animations:{
            self.imgImage!.frame.origin.y += 350
        }){_ in
            UIView.animateKeyframes(withDuration: 1, delay: 0.25, options: [.autoreverse, .repeat], animations: {
                self.imgImage!.frame.origin.y -= 350
            })
        }
        imgImage?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgImage?.bottomAnchor.constraint(equalTo: startedButton.topAnchor, constant: 0).isActive = true
    }
    
    @objc func btnGetStartedAction() {
        let v = Quiz()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(v, animated: true)
    }
       
    func inputButton() {
        self.view.addSubview(startedButton)
        startedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startedButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        startedButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 200).isActive = true
    }
}
