//
//  Persistance.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/19/23.
//

import Foundation

struct playerSkillSaveData: Hashable, Codable{
    var name: String
    var xp: Int
    var unlockedLocations: Set<String>
}

struct idleData: Hashable, Codable{
    var locationId: String
    var startDate: Date
}

struct SaveData: Codable{
    var psData: [playerSkillSaveData]
    var currency: Int
    var inventory: InventoryContent
    var inventorySize: Int
    var equipped: [ItemType:String?]
    
    var currentIdle: idleData?
    
    enum CodingKeys: String, CodingKey{
        case psData, currency, inventory, inventorySize, equipped, currentIdle
    }
}

struct Persistance{
    // Load data
    func loadData(manager: Manager){
        do{
            let jsonSD = UserDefaults.standard.data(forKey: "saveData")
            guard jsonSD != nil else {manager.isFirstLaunch = true; return}
            let decoder = JSONDecoder()
            let sd = try decoder.decode(SaveData.self, from: jsonSD!)
            
            sd.inventory.slots.forEach{ slot in
                if let item = Item.lookup(slot.item_id){
                    manager.inventory.items[item] = slot.quantity
                }else{
                    print("Failed to import item from save data: \(slot.item_id)")
                }
            }
            manager.inventory.maxSlots = sd.inventorySize
            manager.inventory.equipment.equipped = sd.equipped
            manager.currency = sd.currency
            
            let lookup: [String: playerSkillSaveData] = Dictionary(uniqueKeysWithValues: sd.psData.map { ($0.name, $0) })
            
            manager.playerSkills = Skill.allSkills.map({ skill in
                if let skillSD: playerSkillSaveData = lookup[skill.id]{
                    let xp = skillSD.xp
                    let ul = skillSD.unlockedLocations
                    return PlayerSkill(skill: skill, experience: xp, unlockedLocations: ul)
                }else{
                    return PlayerSkill(skill: skill, experience: 0, unlockedLocations: [])
                }
            })
            
            manager.currentIdle = sd.currentIdle
        }catch{
            manager.isFirstLaunch = true
        }
    }
    
    // Save data
    func saveData(manager: Manager){
        let psData = manager.playerSkills.map({
            return playerSkillSaveData(name: $0.name, xp: $0.experience, unlockedLocations: $0.unlockedLocations)
        })
        
        let sd = SaveData(psData: psData, currency: manager.currency, inventory: manager.inventory.inventoryContent, inventorySize: manager.inventory.maxSlots, equipped: manager.inventory.equipment.equipped as! [ItemType:String?], currentIdle: manager.currentIdle)
        
        do{
            let encoder = JSONEncoder()
            let jsonSD = try encoder.encode(sd)
            UserDefaults.standard.setValue(jsonSD, forKey: "saveData")
        }catch{
            print("Failed to save user data")
        }
    }
}
