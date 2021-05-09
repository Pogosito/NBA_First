//
//  FirstPage.swift
//  LectionScrollView
//
//  Created by Погос  on 11.11.2019.
// Copyright © 2019 Погос . All rights reserved.
//

import UIKit

class FirstPage: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let games = UINavigationController(rootViewController: GamesCollectionView())
        let favoritePlayers = UINavigationController(rootViewController: FavoritePlayersViewController())
        let quizPage = UINavigationController(rootViewController: QuizVC())
        viewControllers = [games, favoritePlayers, quizPage]
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.barTintColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "AvenirNextCondensed-Bold", size: 28)!]
    }
}


