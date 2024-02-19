//
//  Skill+Data.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import Foundation

extension Skill{
    // Woodcutting Skill
    static var woodcuttingSkill: Skill = Skill(
        type: .woodcutting,
        locations: [
            SkillLocation.beginnersGrove,
            SkillLocation.forestClearing,
            SkillLocation.mahoganyGrove,
            SkillLocation.cedarValley,
            SkillLocation.redwoodForest
        ]
    )
    // Mining Skill
    static var miningSkill: Skill = Skill(
        type: .mining,
        locations: [
            SkillLocation.copperVein,
            SkillLocation.silverMine,
            SkillLocation.ironOreDeposit,
            SkillLocation.goldMine,
            SkillLocation.diamondCave
        ]
    )

    // Fishing Skill
    static var fishingSkill: Skill = Skill(
        type: .fishing,
        locations: [
            SkillLocation.fishingPond,
            SkillLocation.riverBank,
            SkillLocation.catfishCove,
            SkillLocation.salmonStream,
            SkillLocation.goldenLake
        ]
    )

    // Foraging Skill
    static var foragingSkill: Skill = Skill(
        type: .foraging,
        locations: [
            SkillLocation.openMeadow,
            SkillLocation.woodlandThicket,
            SkillLocation.mushroomGrove,
            SkillLocation.strawberryPatch,
            SkillLocation.truffleForest
        ]
    )
    
    // All Skills
    static var allSkills: [Skill] = [.woodcuttingSkill, .miningSkill, .fishingSkill, .foragingSkill]
}
