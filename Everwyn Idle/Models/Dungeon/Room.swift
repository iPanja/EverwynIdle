//
//  Room.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/22/23.
//

import Foundation

enum RoomType: CaseIterable, Codable {
    case standard
    case resource
    case treasure
    case boss
}

struct Room: Identifiable {
    enum CodingKeys: String, CodingKey {
        case name, id, tiles, type
    }
    
    var tiles: [TileProtocol]
    var name: String
    var type: RoomType
    
    var id = UUID()
    
    var isCleared: Bool {
        tiles.filter({!$0.isDisabled}).count == 0
    }
}

extension Room {
    static func genStandardRoom() -> Room {
        return Room(tiles: [EnemyTile(), ResourceTile(), EmptyTile(), EmptyTile(), ResourceTile(), LootTile(), Tile.RandomTile(), Tile.RandomTile(), Tile.RandomTile()].shuffled(), name: "Standard Room", type: .standard)
    }
    static func genResourceRoom() -> Room {
        return Room(tiles: [ResourceTile(), ResourceTile(), ResourceTile(), EmptyTile(), EmptyTile(), ResourceTile(), EmptyTile(), Tile.RandomTile(), Tile.RandomTile()].shuffled(), name: "Resource Room", type: .resource)
    }
    
    static func genTreasureRoom() -> Room {
        return Room(tiles: [ResourceTile(), ResourceTile(), EmptyTile(), LootTile(), LootTile(), EmptyTile(), Tile.RandomTile(), Tile.RandomTile(), Tile.RandomTile()].shuffled(), name: "Treasure Room", type: .treasure)
    }
    
    static func genBossRoom() -> Room{
        return Room(tiles: [EnemyTile(), EmptyTile(), EmptyTile(), Tile.RandomTile(), Tile.RandomTile(), Tile.RandomTile(), EmptyTile(), Tile.RandomTile(), Tile.RandomTile()].shuffled(), name: "Boss Room", type: .boss)
    }
    
    static func genRoom(type: RoomType) -> Room {
        switch(type){
        case .boss:
            genBossRoom()
        case .treasure:
            genTreasureRoom()
        case .resource:
            genResourceRoom()
        case .standard:
            genStandardRoom()
        }
    }
}

extension Room: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(UUID.self, forKey: .id)
        type = try container.decode(RoomType.self, forKey: .type)
        
        var tileContainer = try container.nestedUnkeyedContainer(forKey: .tiles)
        var _tiles: [TileProtocol] = []

        while !tileContainer.isAtEnd {
            if let tile = try? tileContainer.decode(EnemyTile.self) {
                _tiles.append(tile)
            }else if let tile = try? tileContainer.decode(ResourceTile.self) {
                _tiles.append(tile)
            }else if let tile = try? tileContainer.decode(LootTile.self) {
                _tiles.append(tile)
            }else if let tile = try? tileContainer.decode(EmptyTile.self) {
                _tiles.append(tile)
            }
        }
        
        self.tiles = _tiles
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(id, forKey: .id)
        
        var tileContainer = container.nestedUnkeyedContainer(forKey: .tiles)

        for tile in tiles {
            if let tile = tile as? EnemyTile {
                try tileContainer.encode(tile)
            }else if let tile = tile as? ResourceTile {
                try tileContainer.encode(tile)
            }else if let tile = tile as? LootTile {
                try tileContainer.encode(tile)
            }else if let tile = tile as? EmptyTile {
                try tileContainer.encode(tile)
            }
        }
    }
}

