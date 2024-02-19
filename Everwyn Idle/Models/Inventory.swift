//
//  Inventory.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/17/23.
//

import Foundation

struct Inventory{
    var items: [Item: Int]
    var maxSlots: Int
    var equipment: Equipment = Equipment()
        
    mutating func addItem(_ item: Item, quantity: Int = 1) -> Bool{
        if items.keys.contains(item) || items.count < maxSlots{
            if let prevQuantity = items[item]{
                items[item] = prevQuantity + quantity
            }else{
                items[item] = quantity
            }
            
            return true
        }
        return false
    }
    
    mutating func addItem(itemId: String, quantity: Int = 1) -> Bool{
        if let item = (self.items.first(where: {$0.key.id == itemId})?.key ?? Item.lookup(itemId)){
            return self.addItem(item, quantity: quantity)
        }
        print("Could not find item...")
        return false
    }
    
    mutating func removeItem(_ item: Item, quantity: Int = 1) -> Bool{
        if let prevQuantity = items[item]{
            if prevQuantity - quantity <= 0{
                items.removeValue(forKey: item)
            }else{
                items[item] = prevQuantity - quantity
            }
            
            return true
        }
        
        return false
    }
    
    mutating func removeSlots(slotOffsets: IndexSet){
        // inventoryContent is a computed property => save a copy so it doesn't change as we delete things
        for i in (0...inventoryContent.slots.count){
            if slotOffsets.contains(i){
                // Delete from dict
                if let itemRef = items.keys.first(where: {$0.id == inventoryContent.slots[i].item_id}){
                    items.removeValue(forKey: itemRef)
                }else{
                    print("already removed?")
                }
            }
        }
    }
    
    mutating func removeSlots(slot_ids: Set<String>){
        let keys = items.keys.filter { slot_ids.contains(($0 as Item).name) }
        for key in keys {
            items[key] = nil
        }
    }
    
    var isFull: Bool {
        return items.count >= maxSlots
    }
    
    var inventoryContent: InventoryContent{
        let slots = items.map({ kvp in
            Slot(item_id: kvp.key.id, quantity: kvp.value)
        })
        
        // This is sorted so that the inventory view displays them in a consistent way
        // This enables us to use the onDelete method which passes indices of which elements to delete
        return InventoryContent(slots: slots.sorted(by: {$0.item_id < $1.item_id}))
    }
}
