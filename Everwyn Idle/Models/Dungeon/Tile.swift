//
//  Tile.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/22/23.
//

import Foundation
import SwiftUI

protocol TileProtocol: Codable {
    var isDisabled: Bool { get }
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var primaryValue: Double { get }
    
    var name: String { get }
    var id: UUID { get }
    
    func onTap(manager: Manager) -> (message: String?, error: String?, action: PlayerAction?)
}

class Tile {
    static func RandomTile() -> TileProtocol {
        return [ResourceTile(), EnemyTile(), EmptyTile(), LootTile()].randomElement()!
    }
}

class EnemyTile: TileProtocol {
    enum CodingKeys: String, CodingKey {
        case name, id, enemy
    }
    
    var name: String = "Enemy"
    var id: UUID = UUID()
    
    var primaryColor: Color = Color.red
    var secondaryColor: Color = Color.gray
    
    var enemy: Enemy
    
    init(){
        enemy = Enemy.random()
    }
    
    var isDisabled: Bool {
        return !enemy.isAlive
    }
    
    var primaryValue: Double {
        enemy.hpPercentage
    }
    
    func onTap(manager: Manager) -> (message: String?, error: String?, action: PlayerAction?) {
        // Attack Round!
        // Player attack enemy
        let prevHP = enemy.hp
        enemy.receiveAttack(power: manager.inventory.equipment.currentPower)
        let dmg = abs(enemy.hp - prevHP)
        
        // Enemy attack player
        if enemy.isAlive{
            manager.receiveAttack(power: enemy.attackPoints)
            return ("You did \(dmg) damage!", .none, PlayerAction(type: .attackEnemy, tileId: id, damageAmount: dmg))
        }
        
        let luck = Double.random(in: 0.15...0.35)
        let shards = Int(Double(enemy.maxHealth) * luck)
        manager.currency += shards
        return ("You killed an enemy and found $\(shards)", .none, PlayerAction(type: .attackEnemy, tileId: id, damageAmount: dmg))
    }
}

class ResourceTile: TileProtocol {
    enum CodingKeys: String, CodingKey {
        case name, id, harvested
    }
    
    var name: String = "Resource"
    var id: UUID = UUID()
    
    var primaryColor: Color = Color.brown
    var secondaryColor: Color = Color.gray
    
    var primaryValue: Double = 1.0
    
    var harvested: Bool = false
    
    var isDisabled: Bool {
        return harvested
    }
    
    func onTap(manager: Manager) -> (message: String?, error: String?, action: PlayerAction?) {
        // Button should be disabled if already already harvested, and so this method will not be called again
        let randomLoc = SkillLocation.allLocations.randomElement()!
        let randomRewardId = randomLoc.randomReward()
        
        if manager.inventory.addItem(itemId: randomRewardId){
            harvested = true
            return ("You found a(n) \(randomRewardId)!", .none, PlayerAction(type: .disableTile, tileId: id))
        }
        
        return (.none, "Oh no, your inventory is full!", .none)
    }
}

class LootTile: TileProtocol {
    enum CodingKeys: String, CodingKey {
        case name, id, rewarded
    }
    
    var name: String = "Loot"
    var id: UUID = UUID()
    
    var primaryColor: Color = Color.yellow
    var secondaryColor: Color = Color.gray
    
    var primaryValue: Double = 1.0
    
    var rewarded: Bool = false
    
    var isDisabled: Bool {
        return rewarded
    }
    
    func onTap(manager: Manager) -> (message: String?, error: String?, action: PlayerAction?) {
        let item = Item.allItems.randomElement()!
        rewarded = true
        
        if manager.inventory.addItem(itemId: item.id){
            return ("You found a(n) : \(item.id)", .none, PlayerAction(type: .disableTile, tileId: id))
        }
        
        return (.none, "Your inventory was full, sorry!", PlayerAction(type: .disableTile, tileId: id))
    }
    
}

class SkillCheckTile: Tile {
    
}

class EmptyTile: TileProtocol {
    enum CodingKeys: String, CodingKey {
        case name, id
    }
    
    var name: String = "Empty"
    var id: UUID = UUID()
    
    var primaryColor: Color = Color.gray
    var secondaryColor: Color = Color.gray
    
    var primaryValue: Double = 0
    
    func onTap(manager: Manager) -> (message: String?, error: String?, action: PlayerAction?) {
        /* do nothing */
        return (.none, .none, .none)
    }
    
    var isDisabled: Bool {
        return true
    }
}
