//
//  InventoryContent.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/20/23.
//

import Foundation

struct Slot: Codable, Identifiable, Hashable{
    var item_id: String
    var quantity: Int
    
    public var id: String { item_id }
    
    var isConsumable: Bool {
        return Item.lookup(item_id)?.type == .consumable
    }
}

struct InventoryContent: Codable{
    var slots: [Slot]
}
