//
//  Games.swift
//  LectionScrollView
//
//  Created by Погос  on 13.11.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit


class GamesCollectionView: UIViewController, UISearchBarDelegate{
    
    static let reuseId = "GamesCollection"
    var galleryCollectionView = GalleryCollectionView()
    
    var searchController: UISearchController = {
        var search = UISearchController()
//        search.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
//        search.searchBar.searchTextField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        search.searchBar.placeholder = "yyyy-MM-dd"
        return search
    }()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "Games"), tag: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !(InternetConnection.Connection()) {
            self.Alert(Message: "Please check your internet connection.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NBA"
        navigationItem.searchController = searchController
//        searchController.searchBar.searchTextField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchController.searchBar.delegate = (self as UISearchBarDelegate)
        
        view.addSubview(galleryCollectionView)
        inputGalleryCollectionView()
        showSpinner(onView : view)
        downloadGameDescription("")
    }
    
    func Alert (Message: String) {
        let alert = UIAlertController(title: "OOPS", message: Message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in self.viewDidAppear(true)
        }))
                 
        self.present(alert, animated: true, completion: nil)
        removeSpinner()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let date = (searchBar.text)!
        becomeFirstResponder()
        searchController.isActive = false
        deleteData()
        showSpinner(onView : view)
        if containsOnlyLetters(input: date){
            downloadGameDescription(date)
        } else {
            notFoundDate()
            removeSpinner()
        }
    }
    
    func containsOnlyLetters(input: String) -> Bool {
        for chr in input {
            if (!((chr >= "0" && chr <= "9") || (chr == "-"))) {
                return false
            }
        }
        return true
    }
    
    func deleteData() {
        AppDelegate.shared.array.removeAll()
        AppDelegate.shared.logos.removeAll()
        galleryCollectionView.reloadData()
    }

    func inputGalleryCollectionView() {
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        galleryCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

extension GamesCollectionView {
    
    func notFoundDate() {
        let alert = UIAlertController(title: "OOPS", message: " Please enter a valid date. Example: 2019-12-04", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            self.viewWillAppear(true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    func downloadGameDescription(_ date: String) {
        Net.shared.getDescriptionGame(date: date) { [weak self] (result) in
            switch result {
            case .success(let Description):
            DispatchQueue.main.async {
                self!.preparingData(Description)
                print("Description:")
                print(Description)
                print("----------------")
                if (Description.api.status == 404) {
                    self!.notFoundDate()
                }
                self?.removeSpinner()
                self?.galleryCollectionView.reloadData()
            }
            case .failure(let error):
                self!.notFoundDate()
                print("1")
                print(error.localizedDescription)
            }
        }
    }

    func preparingData(_ list: NBA) {
        var logs: logoImages
        var gameResult: gameDescription
        var myScore = list.api.games
        var flag = 1
        for index in 0 ..< myScore.count {
           
            if (myScore[index].hTeam.logo == "" ){
                myScore[index].hTeam.logo = "https://cdn1.savepice.ru/uploads/2019/12/8/b9ed7649f8f09c81a92bd2026be3adf3-full.jpg"
            }
            if (myScore[index].vTeam.logo == "" ) {
                myScore[index].vTeam.logo = "https://cdn1.savepice.ru/uploads/2019/12/8/b9ed7649f8f09c81a92bd2026be3adf3-full.jpg"
            }
            do {
                flag = 2
                let dataHomeLogo = try Data(contentsOf: URL(string: myScore[index].hTeam.logo)!)
                flag = 3
                let dataVisitLogo = try Data(contentsOf: URL(string: myScore[index].vTeam.logo)!)
                let parsedVisitLogo = UIImage(data: dataVisitLogo)
                let parsedHomeLogo  = UIImage(data: dataHomeLogo)
                logs = logoImages(home: parsedHomeLogo!, visit: parsedVisitLogo!)
                AppDelegate.shared.logos.append(logs)
            } catch {
                print(error.localizedDescription)
                logs = logoImages(home: UIImage(named: "12"), visit: UIImage(named: "12"))
                AppDelegate.shared.logos.append(logs)
            }
            if(myScore[index].vTeam.score.points != ""){
                gameResult = gameDescription(visitScore: myScore[index].vTeam.score.points, homeScrore: myScore[index].hTeam.score.points, statusGame: myScore[index].statusGame, vName: myScore[index].vTeam.fullName, hName: myScore[index].hTeam.fullName)
            } else {
                gameResult = gameDescription(visitScore: "-", homeScrore: "-", statusGame: myScore[index].statusGame, vName: myScore[index].vTeam.fullName, hName: myScore[index].hTeam.fullName)
            }
            AppDelegate.shared.array.append(gameResult)
        }
    }
}

var vSpinner : UIView?

extension UIViewController {

    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
