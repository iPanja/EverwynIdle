//
//  Item+Consumables.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/1/23.
//

import Foundation

extension Item{
    /* RUNES */
    static var basicPotion: Item = Item(name: "Basic Potion", description: "A very basic potion...", value: 25, type: .consumable, extraData: ConsumableData(healing: 30))
    static var epicPotion: Item = Item(name: "Epic Potion", description: "Look at the name!", value: 50, type: .consumable, extraData: ConsumableData(healing: 60))
    
    static var allConsumableItems: [Item] = [.basicPotion, .epicPotion]
}
