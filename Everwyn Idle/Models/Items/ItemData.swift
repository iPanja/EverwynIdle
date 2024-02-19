//
//  ItemData.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/10/23.
//

import Foundation

protocol ItemData: Hashable, Equatable, Codable {}

struct WeaponData: ItemData{
    var damage: Int
}
struct ArmorData: ItemData{
    var defense: Int
}
struct ConsumableData: ItemData{
    var healing: Int
}
