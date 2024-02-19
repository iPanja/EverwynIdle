//
//  Equipment+Dungeon.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/29/23.
//

import Foundation

extension Equipment{
    var currentPower: Int {
        guard let equippedWeaponId = equipped[.weapon] else {return 5}
        
        if let equippedWeaponId {
            if let weaponItem = Item.lookup(equippedWeaponId){
                if let weaponData = weaponItem.extraData as? WeaponData {
                    return weaponData.damage
                }
            }
        }
        
        // No weapon equipped
        return 5 // hand damage?
    }
    
    var currentDefense: Int {
        guard let equippedWeaponId = equipped[.armor] else {return 5}
        
        if let equippedWeaponId {
            if let weaponItem = Item.lookup(equippedWeaponId){
                if let weaponData = weaponItem.extraData as? WeaponData {
                    return weaponData.damage
                }
            }
        }
        
        // No armor equipped
        return 5 // skin protection?
    }
}
