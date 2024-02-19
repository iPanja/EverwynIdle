//
//  Manager+Inventory.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/1/23.
//

import Foundation
import SwiftUI

extension Manager{
    func getEquipmentBinding(itemType: ItemType) -> Binding<String?>{ // Item ID (String)
        return Binding{
            if let itemId = self.inventory.equipment.equipped[itemType]{
                return itemId
            }else{
                return (String?).none
            }
        }set: { newItemId in
            self.inventory.equipment.equipped[itemType] = newItemId
        }
    }
    
    func purchaseProduct(item_id: String, quantity: Int) -> String?{
        let cost = (Item.lookup(item_id)?.value ?? 0) * quantity
        if currency < cost{
            return "Insufficient funds!"
        }
        
        let item = Item.lookup(item_id)
        guard item != .none else {return "Error, item not found!"}
        
        if !inventory.addItem(item!, quantity: quantity){
            if inventory.isFull{
                return "No inventory space!" // Most likely why addItem() failed...
            }
            
            return "Miscellaneous error!"
        }
        
        currency -= cost
        return Optional.none
    }
    
    func sellProduct(item_id: String, quantity: Int) -> String?{
        let worth = (Item.lookup(item_id)?.value ?? 0) * quantity
        if worth < 0{
            return "Problem finding item worth!"
        }
        
        let userItem = inventory.items.first(where: {$0.key.id == item_id})
        if userItem == nil{
            return "Could not find item in your inventory!"
        }
        
        let item = Item.lookup(item_id)
        guard item != .none else {return "Error, item not found!"}
        
        if !inventory.removeItem(item!, quantity: quantity){
            return "Miscellaneous error!"
        }
        
        currency += worth
        return Optional.none
    }
}
