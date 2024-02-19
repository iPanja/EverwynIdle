//
//  Item+Weapons.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/17/23.
//

import Foundation

extension Item{
    /* WOOD */
    static var oakWood: Item = Item(name: "Oak Wood", description: "A sturdy oak wood plank.", value: 5, type: .resource)
    static var pineWood: Item = Item(name: "Pine Wood", description: "A lightweight pine wood board.", value: 3, type: .resource)
    static var mahoganyWood: Item = Item(name: "Mahogany Wood", description: "High-quality mahogany lumber.", value: 10, type: .resource)
    static var cedarWood: Item = Item(name: "Cedar Wood", description: "A fragrant and durable cedar plank.", value: 12, type: .resource)
    static var redwood: Item = Item(name: "Redwood", description: "A rare and beautiful redwood timber.", value: 15, type: .resource)
    
    /* MINERALS */
    static var copperIngot: Item = Item(name: "Copper Ingot", description: "A refined copper ingot.", value: 20, type: .resource)
    static var silverOre: Item = Item(name: "Silver Ore", description: "A chunk of silver ore with industrial applications.", value: 25, type: .resource)
    static var ironOre: Item = Item(name: "Iron Ore", description: "Raw iron ore for smelting.", value: 15, type: .resource)
    static var goldNugget: Item = Item(name: "Gold Nugget", description: "A small but valuable piece of gold.", value: 50, type: .resource)
    static var diamondShard: Item = Item(name: "Diamond Shard", description: "A small, valuable fragment of a diamond.", value: 100, type: .resource)
    
    /* FISH */
    static var commonCarp: Item = Item(name: "Common Carp", description: "A common fish, but still a source of sustenance.", value: 10, type: .resource)
    static var bronzeBass: Item = Item(name: "Bronze Bass", description: "A bass species with valuable bronze scales.", value: 15, type: .resource)
    static var copperCatfish: Item = Item(name: "Copper Catfish", description: "A unique catfish with copper-colored scales.", value: 20, type: .resource)
    static var silverSalmon: Item = Item(name: "Silver Salmon", description: "A prized catch known for its delicious flavor.", value: 30, type: .resource)
    static var goldenTrout: Item = Item(name: "Golden Trout", description: "A rare and valuable golden-colored trout.", value: 50, type: .resource)
    
    
    /* FORAGING */
    static var edibleHerbs: Item = Item(name: "Edible Herbs", description: "A mixture of wild herbs suitable for cooking or healing.", value: 10, type: .resource)
    static var woodlandNuts: Item = Item(name: "Woodland Nuts", description: "Assorted nuts for a quick and nutritious snack.", value: 15, type: .resource)
    static var forestMushroom: Item = Item(name: "Forest Mushroom", description: "An edible forest mushroom with a delicate flavor.", value: 20, type: .resource)
    static var wildStrawberries: Item = Item(name: "Wild Strawberries", description: "Sweet and juicy wild strawberries, a delightful treat.", value: 30, type: .resource)
    static var blackTruffle: Item = Item(name: "Black Truffle", description: "A rare and highly sought-after gourmet truffle.", value: 50, type: .resource)
    
    static var allResourceItems: [Item] = [
        oakWood, pineWood, mahoganyWood, cedarWood, redwood, copperIngot, silverOre, ironOre, goldNugget, diamondShard, commonCarp, bronzeBass, copperCatfish, silverSalmon, goldenTrout, edibleHerbs, woodlandNuts, forestMushroom, wildStrawberries, blackTruffle
    ]
}
