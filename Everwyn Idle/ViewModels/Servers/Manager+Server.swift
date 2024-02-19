//
//  Manager+Server.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/5/23.
//

import Foundation

extension Manager {
    func getAdditionalItemsForSale(merchantId: String) -> [Slot] {
        if let slots = self.httpServer.storeData[merchantId]{
            return slots.map({Slot(item_id: $0, quantity: 999)})
        }
        
        return []
    }
    
    func processPlayerAction(_ action: PlayerAction){
        var updated = false
        
        currentDungeon.rooms.forEach{ room in
            room.tiles.forEach{ tile in
                if tile.id == action.tileId {
                    print(action)
                    print(tile)
                    if let tile = tile as? EnemyTile {
                        if action.type == .attackEnemy {
                            if let dmg = action.damageAmount {
                                tile.enemy.hp -= dmg
                                updated = true
                            }
                        }
                    }else{
                        if action.type == .disableTile {
                            if let tile = tile as? ResourceTile{
                                tile.harvested = true
                                updated = true
                            }else if let tile = tile as? LootTile{
                                tile.rewarded = true
                                updated = true
                            }else if let _ = tile as? EmptyTile{
                                // ???
                                updated = true
                            }
                        }
                    }
                }
            }
        }
        
        if !updated {
            print("Failed to update tile from player action")
        }
    }
}
