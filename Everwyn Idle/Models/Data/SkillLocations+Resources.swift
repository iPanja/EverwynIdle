//
//  SkillLocation+Resources.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import Foundation

extension SkillLocation{
    /* WOOD CHOPPING */
    static var beginnersGrove: SkillLocation = SkillLocation(
        name: "Beginner's Grove",
        description: "A tranquil forest with easily accessible trees, perfect for those new to wood chopping.",
        skillName: "Woodcutting",
        skillType: .woodcutting,
        unlockCost: 0,
        unlocked: true,
        requiredLevel: 1,
        productTable: [
            "Oak Wood": 80.0,
            "Pine Wood": 20.0,
            "Mahogany Wood": 0.0,
            "Cedar Wood": 0.0,
            "Redwood": 0.0
        ]
    )
    static var forestClearing: SkillLocation = SkillLocation(
        name: "Forest Clearing",
        description: "A clearing within a dense forest, slightly harder to access but offering a variety of wood types.",
        skillName: "Woodcutting",
        skillType: .woodcutting,
        unlockCost: 50,
        unlocked: false,
        requiredLevel: 5,
        productTable: [
            "Oak Wood": 50.0,
            "Pine Wood": 40.0,
            "Mahogany Wood": 10.0,
            "Cedar Wood": 0.0,
            "Redwood": 0.0
        ]
    )
    static var mahoganyGrove: SkillLocation = SkillLocation(
        name: "Mahogany Grove",
        description: "A secluded grove deep in the forest where valuable mahogany trees can be found.",
        skillName: "Woodcutting",
        skillType: .woodcutting,
        unlockCost: 200,
        unlocked: false,
        requiredLevel: 12,
        productTable: [
            "Oak Wood": 20.0,
            "Pine Wood": 20.0,
            "Mahogany Wood": 50.0,
            "Cedar Wood": 10.0,
            "Redwood": 0.0
        ]
    )
    static var cedarValley: SkillLocation = SkillLocation(
        name: "Cedar Valley",
        description: "A challenging location nestled in a valley, known for its tough cedar trees.",
        skillName: "Woodcutting",
        skillType: .woodcutting,
        unlockCost: 500,
        unlocked: false,
        requiredLevel: 20,
        productTable: [
            "Oak Wood": 10.0,
            "Pine Wood": 10.0,
            "Mahogany Wood": 20.0,
            "Cedar Wood": 50.0,
            "Redwood": 10.0
        ]
    )
    static var redwoodForest: SkillLocation = SkillLocation(
        name: "Redwood Forest",
        description: "The most elusive and rewarding location, featuring enormous and rare redwood trees.",
        skillName: "Woodcutting",
        skillType: .woodcutting,
        unlockCost: 1000,
        unlocked: false,
        requiredLevel: 30,
        productTable: [
            "Oak Wood": 5.0,
            "Pine Wood": 5.0,
            "Mahogany Wood": 10.0,
            "Cedar Wood": 30.0,
            "Redwood": 50.0
        ]
    )
    /* MINING */
    static var copperVein: SkillLocation = SkillLocation(
        name: "Copper Vein",
        description: "An accessible mine with abundant copper deposits.",
        skillName: "Mining",
        skillType: .mining,
        unlockCost: 0,
        unlocked: true,
        requiredLevel: 1,
        productTable: [
            "Copper Ingot": 80.0,
            "Silver Ore": 20.0,
            "Iron Ore": 0.0,
            "Gold Nugget": 0.0,
            "Diamond Shard": 0.0
        ]
    )
    static var silverMine: SkillLocation = SkillLocation(
        name: "Silver Mine",
        description: "A mine rich in valuable silver ore, somewhat harder to access.",
        skillName: "Mining",
        skillType: .mining,
        unlockCost: 50,
        unlocked: false,
        requiredLevel: 5,
        productTable: [
            "Copper Ingot": 40.0,
            "Silver Ore": 40.0,
            "Iron Ore": 20.0,
            "Gold Nugget": 0.0,
            "Diamond Shard": 0.0
        ]
    )
    static var ironOreDeposit: SkillLocation = SkillLocation(
        name: "Iron Ore Deposit",
        description: "A location where iron ore is plentiful but requires more effort to mine.",
        skillName: "Mining",
        skillType: .mining,
        unlockCost: 200,
        unlocked: false,
        requiredLevel: 12,
        productTable: [
            "Copper Ingot": 20.0,
            "Silver Ore": 20.0,
            "Iron Ore": 40.0,
            "Gold Nugget": 20.0,
            "Diamond Shard": 0.0
        ]
    )
    static var goldMine: SkillLocation = SkillLocation(
        name: "Gold Mine",
        description: "A mine known for its precious gold nuggets, a challenge to access.",
        skillName: "Mining",
        skillType: .mining,
        unlockCost: 500,
        unlocked: false,
        requiredLevel: 20,
        productTable: [
            "Copper Ingot": 10.0,
            "Silver Ore": 10.0,
            "Iron Ore": 20.0,
            "Gold Nugget": 50.0,
            "Diamond Shard": 10.0
        ]
    )
    static var diamondCave: SkillLocation = SkillLocation(
        name: "Diamond Cave",
        description: "The most exclusive location where diamond shards are a rare but rewarding find.",
        skillName: "Mining",
        skillType: .mining,
        unlockCost: 1000,
        unlocked: false,
        requiredLevel: 30,
        productTable: [
            "Copper Ingot": 5.0,
            "Silver Ore": 5.0,
            "Iron Ore": 10.0,
            "Gold Nugget": 30.0,
            "Diamond Shard": 50.0
        ]
    )
    /* FISHING */
    static var fishingPond: SkillLocation = SkillLocation(
        name: "Fishing Pond",
        description: "A peaceful pond teeming with common carp and other easily caught fish.",
        skillName: "Fishing",
        skillType: .fishing,
        unlockCost: 0,
        unlocked: true,
        requiredLevel: 1,
        productTable: [
            "Common Carp": 80.0,
            "Bronze Bass": 20.0,
            "Copper Catfish": 0.0,
            "Silver Salmon": 0.0,
            "Golden Trout": 0.0
        ]
    )
    static var riverBank: SkillLocation = SkillLocation(
        name: "River Bank",
        description: "Fishing by the river where bronze bass make a tasty catch.",
        skillName: "Fishing",
        skillType: .fishing,
        unlockCost: 50,
        unlocked: false,
        requiredLevel: 5,
        productTable: [
            "Common Carp": 50.0,
            "Bronze Bass": 40.0,
            "Copper Catfish": 10.0,
            "Silver Salmon": 0.0,
            "Golden Trout": 0.0
        ]
    )
    static var catfishCove: SkillLocation = SkillLocation(
        name: "Catfish Cove",
        description: "A location known for the elusive copper catfish, requiring better fishing skills.",
        skillName: "Fishing",
        skillType: .fishing,
        unlockCost: 200,
        unlocked: false,
        requiredLevel: 12,
        productTable: [
            "Common Carp": 20.0,
            "Bronze Bass": 20.0,
            "Copper Catfish": 50.0,
            "Silver Salmon": 10.0,
            "Golden Trout": 0.0
        ]
    )
    static var salmonStream: SkillLocation = SkillLocation(
        name: "Salmon Stream",
        description: "A fast-flowing stream where silver salmon are a prized catch.",
        skillName: "Fishing",
        skillType: .fishing,
        unlockCost: 500,
        unlocked: false,
        requiredLevel: 20,
        productTable: [
            "Common Carp": 10.0,
            "Bronze Bass": 10.0,
            "Copper Catfish": 20.0,
            "Silver Salmon": 50.0,
            "Golden Trout": 10.0
        ]
    )
    static var goldenLake: SkillLocation = SkillLocation(
        name: "Golden Lake",
        description: "A secluded lake where the rare golden trout can be found, offering a rewarding challenge.",
        skillName: "Fishing",
        skillType: .fishing,
        unlockCost: 1000,
        unlocked: false,
        requiredLevel: 30,
        productTable: [
            "Common Carp": 5.0,
            "Bronze Bass": 5.0,
            "Copper Catfish": 10.0,
            "Silver Salmon": 30.0,
            "Golden Trout": 50.0
        ]
    )
    /* FORAGING */
    static var openMeadow: SkillLocation = SkillLocation(
        name: "Open Meadow",
        description: "A spacious meadow with an abundance of edible herbs and woodland nuts.",
        skillName: "Foraging",
        skillType: .foraging,
        unlockCost: 0,
        unlocked: true,
        requiredLevel: 1,
        productTable: [
            "Edible Herbs": 80.0,
            "Woodland Nuts": 20.0,
            "Forest Mushroom": 0.0,
            "Wild Strawberries": 0.0,
            "Black Truffle": 0.0
        ]
    )

    static var woodlandThicket: SkillLocation = SkillLocation(
        name: "Woodland Thicket",
        description: "A densely wooded area with a variety of edible plants, including forest mushrooms.",
        skillName: "Foraging",
        skillType: .foraging,
        unlockCost: 50,
        unlocked: false,
        requiredLevel: 5,
        productTable: [
            "Edible Herbs": 50.0,
            "Woodland Nuts": 30.0,
            "Forest Mushroom": 20.0,
            "Wild Strawberries": 0.0,
            "Black Truffle": 0.0
        ]
    )
    static var mushroomGrove: SkillLocation = SkillLocation(
        name: "Mushroom Grove",
        description: "A dedicated grove where forest mushrooms are in abundance.",
        skillName: "Foraging",
        skillType: .foraging,
        unlockCost: 200,
        unlocked: false,
        requiredLevel: 12,
        productTable: [
            "Edible Herbs": 30.0,
            "Woodland Nuts": 30.0,
            "Forest Mushroom": 30.0,
            "Wild Strawberries": 10.0,
            "Black Truffle": 0.0
        ]
    )
    static var strawberryPatch: SkillLocation = SkillLocation(
        name: "Strawberry Patch",
        description: "A patch of wild strawberries, a little harder to access but worth the effort.",
        skillName: "Foraging",
        skillType: .foraging,
        unlockCost: 500,
        unlocked: false,
        requiredLevel: 20,
        productTable: [
            "Edible Herbs": 20.0,
            "Woodland Nuts": 20.0,
            "Forest Mushroom": 20.0,
            "Wild Strawberries": 40.0,
            "Black Truffle": 0.0
        ]
    )
    static var truffleForest: SkillLocation = SkillLocation(
        name: "Truffle Forest",
        description: "A forest known for its black truffles, a rare find for skilled foragers.",
        skillName: "Foraging",
        skillType: .foraging,
        unlockCost: 1000,
        unlocked: false,
        requiredLevel: 30,
        productTable: [
            "Edible Herbs": 10.0,
            "Woodland Nuts": 10.0,
            "Forest Mushroom": 10.0,
            "Wild Strawberries": 30.0,
            "Black Truffle": 50.0
        ]
    )
    
    /* LIST */
    static var allLocations: [SkillLocation] = [
        beginnersGrove,
        forestClearing,
        mahoganyGrove,
        cedarValley,
        redwoodForest,
        copperVein,
        silverMine,
        ironOreDeposit,
        goldMine,
        diamondCave,
        fishingPond,
        riverBank,
        catfishCove,
        salmonStream,
        goldenLake,
        openMeadow,
        woodlandThicket,
        mushroomGrove,
        strawberryPatch,
        truffleForest
    ]
}
