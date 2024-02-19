//
//  Manager+Dungeon.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/26/23.
//

import Foundation
import SwiftUI

extension Manager{
    var currentRoom: Room{
        if let roomId = currentRoomId{
            if let room = currentDungeon.rooms.first(where: {$0.id == roomId}) {
                return room
            }
        }
        
        return Room(tiles: [], name: "error", type: .standard)
    }
    
    func moveDirection(_ direction: Direction) {
        if currentDungeon.hasNeighbor(room: currentRoom, direction: direction) {
            let newRoomId = currentDungeon.getNeighbors(currentRoom)[direction]
            currentRoomId = newRoomId
        }
    }
    
    func getCurrentRoom() -> Binding<Room>{
        return Binding{
            return self.currentRoom
        }set: { newRoom in }
    }
    
    func receiveAttack(power: Int){ // Based of Gen1 Pokemon Damage Formula
        let luck = Double.random(in: 0.75...1)
        let baseMult: Double = 3.0
        let damage: Int = Int(baseMult * Double(power)/Double(self.inventory.equipment.currentDefense) * luck)
        withAnimation{
            self.currentHp -= damage
        }
    }
    
    func useConsumable(_ item_id: String){
        if let item = Item.lookup(item_id){
            if let consumableData = item.extraData as? ConsumableData{
                if self.inventory.removeItem(item, quantity: 1){
                    withAnimation{
                        self.currentHp += consumableData.healing
                    }
                }
            }
        }
    }
}
