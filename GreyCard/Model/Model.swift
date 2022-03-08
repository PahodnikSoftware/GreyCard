//
//  Model.swift
//  GreyCard
//
//  Created by Leo on 01.03.2022.
//

import Foundation

class Game {
    
    static let shared = Game()
    
    var playersLeftInGame: [String] = []  //players currently at the table (in game)
    var playersOnEvent: [String] = []  //players on current event (day)
    var playersDataBase: [String] = []  //all players from previous events
    
    init() {
        //load userDefaults
        self.playersOnEvent = UserDefaults.standard.object(forKey: "playersOnEvent") as? [String] ?? []
        self.playersDataBase = UserDefaults.standard.object(forKey: "playersDataBase") as? [String] ?? []
    }
}
