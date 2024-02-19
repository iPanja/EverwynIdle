//
//  PlayerSkill.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/19/23.
//

import Foundation

struct PlayerSkill: Identifiable{
    var skill: Skill
    var level: Int {
        calcLevel
    }
    var experience: Int
    var unlockedLocations: Set<String>
    
    var id: String { skill.id }
    var name: String { skill.name }
    var type: SkillType { skill.type }
    
    static let standard = PlayerSkill(skill: .foragingSkill, experience: 125, unlockedLocations: Set<String>([SkillLocation.beginnersGrove.id]))
}

// Locations
extension PlayerSkill{
    func isUnlocked(location: SkillLocation) -> Bool{
        return unlockedLocations.contains(location.id) || location.unlocked // the latter is to handle beginner areas, unlocked by default
    }
}

// Leveling
extension PlayerSkill{
    static let xpPower: Double = 1.5
    static let xpBase: Int = 100
    
    private var thisLevelXPRequirement: Int{
        Int(Double(PlayerSkill.xpBase) * pow(Double(level-1), PlayerSkill.xpPower))
    }
    
    var nextLevelTotalXP: Int {
        Int(Double(PlayerSkill.xpBase) * pow(Double(level), PlayerSkill.xpPower))
    }
    
    var nextLevelRemainingXP: Int {
        nextLevelTotalXP - experience
    }
    
    var nextLevelProgression: Double {
        Double(experience-thisLevelXPRequirement)/Double(nextLevelTotalXP - thisLevelXPRequirement)
    }
    
    var nextLevelProgressionFS: String{
        let num = experience - thisLevelXPRequirement
        let denom = nextLevelTotalXP - thisLevelXPRequirement
        return "(\(num)/\(denom))"
    }
    
    private var calcLevel: Int {
        var _level = 1

        while true{
            if experience < Int(Double(PlayerSkill.xpBase) * pow(Double(_level), PlayerSkill.xpPower)){
                break
            }
            _level += 1
        }

        return _level
    }
}
