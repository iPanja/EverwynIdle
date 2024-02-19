//
//  Merchant.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/3/23.
//

import Foundation

struct Merchant: Identifiable{
    var name: String
    var inventory: InventoryContent
    var speciality: ItemType
    
    var id: String { name }
    
    var modes: [Transaction] = [.buy, .sell]
    
    static var WoodsmanWilber = Merchant(name: "Woodsman Wilber", inventory: InventoryContent(slots: [Slot(item_id: "Oak Wood", quantity: 999)]), speciality: .resource)
    static var MinerMike = Merchant(name: "Miner Mike", inventory: InventoryContent(slots: [Slot(item_id: "Copper Ingot", quantity: 999)]), speciality: .resource)
    static var FishermanFiona = Merchant(name: "Fisherman Fiona", inventory: InventoryContent(slots: [Slot(item_id: "Common Carp", quantity: 999)]), speciality: .resource)
    static var ForagerFelix = Merchant(name: "Forager Felix", inventory: InventoryContent(slots: [Slot(item_id: "Edible Herbs", quantity: 999)]), speciality: .resource)
    static var ArmorerAmaranth = Merchant(name: "Armorer Amaranth", inventory: InventoryContent(slots: [Slot(item_id: "Leather Armor", quantity: 999)]), speciality: .armor)
    static var WitchWendy = Merchant(name: "Witch Wendy", inventory: InventoryContent(slots: [Slot(item_id: "Basic Potion", quantity: 999)]), speciality: .consumable)
    
    static var allMerchants = [WoodsmanWilber, MinerMike, FishermanFiona, ForagerFelix, ArmorerAmaranth, WitchWendy]
}
