//
//  Skill.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/17/23.
//

import Foundation

struct Skill: Identifiable{
    var type: SkillType
    var locations: [SkillLocation]
    
    var id: String { name }
    var name: String { type.rawValue }
}

extension Skill{
    static func lookup(_ skillID: String) -> Item?{
        return Item.allItems.first(where: {$0.id == skillID})
    }
}

enum SkillType: String, Identifiable, CaseIterable{
    var id: Self { self }
    
    case woodcutting = "Woodcutting", mining = "Mining", fishing = "Fishing", foraging = "Foraging"
}
