//
//  Enemy.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/22/23.
//

import Foundation

struct Enemy: Codable {
    var maxHealth: Int
    var hp: Int
    
    var attackPoints: Int /* damage */
    var defensePoints: Int /* armor */
    
    mutating func receiveAttack(power: Int){ // Based off of Gen1 Pokemon damage formula (heavily simplified)
        let luck = Double.random(in: 0.75...1)
        let baseMult: Double = 5.0
        let damage: Int = Int(baseMult * Double(power)/Double(self.defensePoints) * luck)
        hp -= damage
    }
    
    var isAlive: Bool {
        return hp > 0
    }
    
    var hpPercentage: Double {
        return Double(hp) / Double(maxHealth)
    }
    
}


extension Enemy {
    static func random() -> Enemy {
        let maxHealth = Int.random(in: 100...200)
        let ap = Int.random(in: 20...30)
        let dp = Int.random(in: 1...8)
        return Enemy(maxHealth: maxHealth, hp: maxHealth, attackPoints: ap, defensePoints: dp)
    }
}
