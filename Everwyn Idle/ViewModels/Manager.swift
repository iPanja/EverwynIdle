//
//  Manager.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import Foundation
import Observation

@Observable
class Manager{
    var httpServer: HTTPServer    
    var persistance: Persistance
    var isFirstLaunch: Bool = false
    
    // Player Data (will be persisted)
    var playerSkills: [PlayerSkill] { didSet{ saveData() } }
    var inventory: Inventory{ didSet{ saveData() } }
    var currency: Int { didSet{ saveData() } }
    var currentIdle: idleData? { didSet{ saveData() } }
    
    // Dungeon Data
    var currentDungeon: Dungeon = Dungeon.random()
    var currentRoomId: UUID? = .none
    var maxHp: Int = 100
    var currentHp: Int = 100
    
    init(){
        // Base data
        playerSkills = Skill.allSkills.map({PlayerSkill(skill: $0, experience: 0, unlockedLocations: [])})
        currency = 0 // will be overwritten regardless by persistance (standard.getValue has a default value (0))
        inventory = Inventory(items: [:], maxSlots: 5)
        
        // Load data
        persistance = Persistance()
        httpServer = HTTPServer()
        persistance.loadData(manager: self)
        
        if isFirstLaunch{
            giveStartingItems()
        }
    }
    
    func saveData(){
        persistance.saveData(manager: self)
    }
    
    func giveStartingItems(){
        inventory.addItem(Item.woodlandNuts, quantity: 5)
        inventory.addItem(Item.ironSword, quantity: 1)
    }
}
