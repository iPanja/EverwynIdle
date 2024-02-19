//
//  Item+Weapons.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/17/23.
//

import Foundation

extension Item{
    /* SWORDS */
    static var ironSword: Item = Item(name: "Iron Sword", description: "A sturdy iron sword.", value: 50, type: .weapon, extraData: WeaponData(damage: 20))
    static var steelSword: Item = Item(name: "Steel Sword", description: "A sharp and durable steel sword.", value: 70, type: .weapon, extraData: WeaponData(damage: 30))
    static var silverSword: Item = Item(name: "Silver Sword", description: "A finely crafted silver sword.", value: 90, type: .weapon, extraData: WeaponData(damage: 40))
    static var obsidianSword: Item = Item(name: "Obsidian Sword", description: "A sword made from sharp obsidian.", value: 110, type: .weapon, extraData: WeaponData(damage: 45))
    static var mithrilSword: Item = Item(name: "Mithril Sword", description: "A sword forged from rare and lightweight mithril.", value: 150, type: .weapon, extraData: WeaponData(damage: 55))
    
    /* ARMOR */
    static var leatherArmor: Item = Item(name: "Leather Armor", description: "Light and flexible leather armor.", value: 40, type: .armor, extraData: ArmorData(defense: 15))
    static var chainmailArmor: Item = Item(name: "Chainmail Armor", description: "Interlocking metal rings provide solid protection.", value: 60, type: .armor, extraData: ArmorData(defense: 20))
    static var plateArmor: Item = Item(name: "Plate Armor", description: "Heavy plate armor for maximum protection.", value: 80, type: .armor, extraData: ArmorData(defense: 25))
    static var steelPlateMail: Item = Item(name: "Steel Plate Mail", description: "A suit of steel plate mail armor for exceptional defense.", value: 70, type: .armor, extraData: ArmorData(defense: 22))
    static var dragonScaleArmor: Item = Item(name: "Dragon Scale Armor", description: "Armor crafted from the scales of a powerful dragon.", value: 100, type: .armor, extraData: ArmorData(defense: 30))
    
    static var allCombatItems: [Item] = [.ironSword, .steelSword, .silverSword, .obsidianSword, .mithrilSword, .leatherArmor, .chainmailArmor, .plateArmor, .steelPlateMail, .dragonScaleArmor]
}
