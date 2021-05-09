//
//  GalleryCollectionView.swift
//  NBA1
//
//  Created by Погос  on 02.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return AppDelegate.shared.array.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell

       
        let logs = AppDelegate.shared.logos[indexPath.item]
        let currentColumn = AppDelegate.shared.array[indexPath.item]
        cell.homeTeamScore.text = String(currentColumn.home!)
        cell.visitorTeamScore.text = String(currentColumn.visit!)
        cell.visitorLogo.image = logs.visitLogo
        cell.homeLogo.image = logs.homeLogo
        cell.statusGame.text = String(currentColumn.status!)
        cell.vTeamName.text = String(currentColumn.vistorName!)
        cell.hTeamName.text = String(currentColumn.homeName!)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: 180)
    }
}

