//
//  ViewController.swift
//  NBA1
//
//  Created by Погос  on 02.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private var currentPage: UIViewController
    
    init(){
        self.currentPage = FirstPage()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentPage.view.frame = view.bounds
        addChild(currentPage)
        view.addSubview(currentPage.view)
    }
}
