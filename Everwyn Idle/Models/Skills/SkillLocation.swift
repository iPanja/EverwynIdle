//
//  SkillLocations.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import Foundation

struct SkillLocation: Identifiable{
    var name: String
    var description: String
    var skillName: String
    var skillType: SkillType
    
    var unlockCost: Int
    var unlocked: Bool
    var requiredLevel: Int
    
    var productTable: [String: Double] // item name -> drop chance
    
    var id: String { name }
}

extension SkillLocation{
    func randomReward() -> String{
        let random = Double.random(in: 0.0...1.0)
        var currentProbability = 0.0
        
        var rewardItemId = ""
        for (itemId, percent) in productTable/*.sorted(by: {$0.value < $1.value})*/{
            currentProbability += (percent / 100)
            if random < currentProbability{
                rewardItemId = itemId
                break
            }
        }
        
        return rewardItemId
    }
}
