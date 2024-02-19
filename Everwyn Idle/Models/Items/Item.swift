//
//  Item.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/17/23.
//

import Foundation

struct Item: Hashable, Equatable, Codable, Identifiable{
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var description: String
    var value: Int
    var type: ItemType
    
    var extraData: (any ItemData)?
    
    enum CodingKeys: String, CodingKey{
        case name, description, value, type //, extraData???
    }
    
    func hash(into hasher: inout Hasher) {
        // Uniquely identify an item.
        hasher.combine(name)
        hasher.combine(type)
    }
    
    var id: String { name }
    
    static var allItems: [Item] = Item.allResourceItems + Item.allRuneItems + Item.allCombatItems + Item.allConsumableItems
}

extension Item{
    static func lookup(_ itemID: String) -> Item?{
        return Item.allItems.first(where: {$0.id == itemID})
    }
    
    static func item_type(_ item_id: String) -> ItemType?{
        if let item = lookup(item_id){
            return item.type
        }
        
        return .none
    }
}
