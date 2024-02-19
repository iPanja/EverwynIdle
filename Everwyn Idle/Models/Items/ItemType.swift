//
//  ItemType.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/10/23.
//

import Foundation

enum ItemType: String, Codable{
    case weapon = "Weapon"
    case armor = "Armor"
    case consumable = "Consumable"
    case resource = "Resource"
    case magicalRune = "Magical Rune"
}
