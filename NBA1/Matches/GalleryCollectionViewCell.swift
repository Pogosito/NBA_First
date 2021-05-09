//
//  GalleryCollectionViewCell.swift
//  NBA1
//
//  Created by Погос  on 02.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit


class GalleryCollectionViewCell: UICollectionViewCell {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppDelegate.shared.array.count
    }
    
    static let reuseId = "GalleryCollectionViewCell"
    
    var vTeamName: UILabel = {
        let vName = UILabel()
        vName.translatesAutoresizingMaskIntoConstraints = false
        vName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        vName.textAlignment = .center
        vName.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        vName.font = UIFont(name: "AvenirNextCondensed-Bold", size: 12)
        return vName
    }()
    
    var hTeamName: UILabel = {
        let hName = UILabel()
        hName.translatesAutoresizingMaskIntoConstraints = false
        hName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        hName.textAlignment = .center
        hName.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        hName.font = UIFont(name: "AvenirNextCondensed-Bold", size: 12)
        return hName
    }()
    
    var statusGame: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        status.textAlignment = .center
        status.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        status.font = UIFont(name: "AvenirNextCondensed-Bold", size: 18)
        return status
    }()
    
    let visitorLogo: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        return logo
    }()
    
    let homeLogo: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        return logo
    }()

    let cellGame: UILabel = {
        let cell = UILabel()
        cell.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 3
        cell.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()
    
    let homeTeamScore: UILabel = {
        let homeFinalSrore = UILabel()
        homeFinalSrore.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        homeFinalSrore.textAlignment = .center
        homeFinalSrore.font.withSize(20)
        homeFinalSrore.font = UIFont.boldSystemFont(ofSize: 25)
        homeFinalSrore.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        homeFinalSrore.translatesAutoresizingMaskIntoConstraints = false
        return homeFinalSrore
    }()
    
    let visitorTeamScore: UILabel = {
        let visitFinalSrore = UILabel()
        visitFinalSrore.backgroundColor =
            #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        visitFinalSrore.textAlignment = .center
        visitFinalSrore.font.withSize(20)
        visitFinalSrore.font = UIFont.boldSystemFont(ofSize: 25)
        visitFinalSrore.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        visitFinalSrore.translatesAutoresizingMaskIntoConstraints = false
        return visitFinalSrore
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellGame)
        cellGame.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cellGame.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95).isActive = true
        cellGame.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        cellGame.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
      
        cellGame.addSubview(visitorTeamScore)
        visitorTeamScore.centerYAnchor.constraint(equalTo: cellGame.centerYAnchor).isActive = true
        visitorTeamScore.heightAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.25).isActive = true
        visitorTeamScore.widthAnchor.constraint(equalTo: cellGame.widthAnchor, multiplier:  0.13).isActive = true
        visitorTeamScore.trailingAnchor.constraint(equalTo: cellGame.trailingAnchor, constant: (-screenWidth / 2 + 7) ).isActive = true
        
        cellGame.addSubview(homeTeamScore)
        homeTeamScore.centerYAnchor.constraint(equalTo: cellGame.centerYAnchor).isActive = true
        homeTeamScore.heightAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.25).isActive = true
        homeTeamScore.widthAnchor.constraint(equalTo: cellGame.widthAnchor, multiplier:  0.13).isActive = true
        homeTeamScore.leadingAnchor.constraint(equalTo: cellGame.leadingAnchor, constant: (screenWidth / 2 - 7)).isActive = true
        
        cellGame.addSubview(visitorLogo)
        visitorLogo.centerYAnchor.constraint(equalTo: cellGame.centerYAnchor).isActive = true
        visitorLogo.heightAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.40).isActive = true
        visitorLogo.widthAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.55).isActive = true
        visitorLogo.trailingAnchor.constraint(equalTo: cellGame.trailingAnchor, constant:   -screenWidth / 1.57).isActive = true
        
        cellGame.addSubview(homeLogo)
        homeLogo.centerYAnchor.constraint(equalTo: cellGame.centerYAnchor).isActive = true
        homeLogo.heightAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.40).isActive = true
        homeLogo.widthAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.55).isActive = true
        homeLogo.leadingAnchor.constraint(equalTo: cellGame.leadingAnchor, constant:  screenWidth / 1.57).isActive = true
        
        cellGame.addSubview(statusGame)
        statusGame.centerXAnchor.constraint(equalTo: cellGame.centerXAnchor).isActive = true
        statusGame.widthAnchor.constraint(equalTo: cellGame.widthAnchor, multiplier: 0.25).isActive = true
        statusGame.heightAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.20).isActive = true
        statusGame.topAnchor.constraint(equalTo: cellGame.topAnchor, constant: 30).isActive = true
        
        cellGame.addSubview(vTeamName)
        vTeamName.topAnchor.constraint(equalTo: cellGame.topAnchor, constant: 123).isActive = true
        vTeamName.widthAnchor.constraint(equalTo: cellGame.widthAnchor, multiplier: 0.22).isActive = true
        vTeamName.heightAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.22).isActive = true
        vTeamName.trailingAnchor.constraint(equalTo: cellGame.trailingAnchor, constant:  -screenWidth / 1.53).isActive = true
        
        cellGame.addSubview(hTeamName)
        hTeamName.topAnchor.constraint(equalTo: cellGame.topAnchor, constant: 123).isActive = true
        hTeamName.widthAnchor.constraint(equalTo: cellGame.widthAnchor, multiplier: 0.22).isActive = true
        hTeamName.heightAnchor.constraint(equalTo: cellGame.heightAnchor, multiplier: 0.22).isActive = true
        hTeamName.leadingAnchor.constraint(equalTo: cellGame.leadingAnchor, constant:  screenWidth / 1.53).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

