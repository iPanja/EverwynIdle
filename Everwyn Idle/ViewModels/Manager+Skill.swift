//
//  Manager+Skill.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/19/23.
//

import Foundation
import SwiftUI

extension Manager{
    func getPlayerSkill(_ type: SkillType) -> Binding<PlayerSkill>{
        return Binding{
            if let playerSkill = self.playerSkills.first(where: {$0.skill.type == type}){
                return playerSkill
            }else{
                assert(false)
                return PlayerSkill.standard
            }
        }set: { newPlayerSkill in }
    }
}
