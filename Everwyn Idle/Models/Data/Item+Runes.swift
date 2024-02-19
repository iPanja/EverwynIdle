//
//  Item+Runes.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/17/23.
//

import Foundation

extension Item{
    /* RUNES */
    static var fireRune: Item = Item(name: "Fire Rune", description: "A magical rune with an affinity for fire elemental spells.", value: 50, type: .magicalRune)
    static var iceRune: Item = Item(name: "Ice Rune", description: "A magical rune with an affinity for ice elemental spells.", value: 30, type: .magicalRune)
    static var lightningRune: Item = Item(name: "Lightning Rune", description: "A magical rune with an affinity for lightning elemental spells.", value: 40, type: .magicalRune)
    static var earthRune: Item = Item(name: "Earth Rune", description: "A magical rune with an affinity for earth elemental spells.", value: 35, type: .magicalRune)
    static var waterRune: Item = Item(name: "Water Rune", description: "A magical rune with an affinity for water elemental spells.", value: 45, type: .magicalRune)
    
    static var allRuneItems: [Item] = [.fireRune, .iceRune, .lightningRune, .earthRune, .waterRune]
}
