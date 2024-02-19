//
//  PlayerEquipment.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/1/23.
//

import Foundation

struct Equipment{
    var equipmentSlotTypes: [ItemType] = [.armor, .weapon]
    var equipped: [ItemType:String?] = [:] // store item_id (String) of the item in the player's inventory they have designated for this slot
    
    func isEquipable(_ itemType: ItemType) -> Bool {
        return equipmentSlotTypes.contains(itemType)
    }
}
