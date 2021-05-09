//
//  Model.swift
//  NBA1
//
//  Created by Погос  on 03.12.2019.
//  Copyright © 2019 Погос . All rights reserved.
//

import UIKit


struct NBA: Codable {
    let api: informationGame
}

struct informationGame: Codable {
    let status: Int
    let message: String
    let results: Int
   
    let games: [Games]
}

struct Games: Codable {
    let statusGame: String
    var vTeam: visitorTeam
    var hTeam: homeTeam
}

struct homeTeam: Codable {
    let score: homeScore
    var logo: String
    let fullName: String
}

struct visitorTeam: Codable {
    let score: visitorScore
    var logo: String
    let fullName: String
}

struct homeScore: Codable {
    let points: String
}

struct visitorScore: Codable {
    let points: String
}
