//
//  DungeonView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/26/23.
//

import SwiftUI

enum DungeonSheetOption: String, Identifiable {
    case map = "Map"
    
    var id: String { self.rawValue }
}

struct DungeonView: View {
    @Environment(Manager.self) var manager
    @Environment(SocketServer.self) var socketServer
    @Environment(\.dismiss) private var dismiss
        
    @Binding var currentRoom: Room
    
    @State var messageNotification: String? = .none
    @State var errorNotification: String? = .none
    
    @State var sheet: DungeonSheetOption? = .none
    
    var body: some View {
        VStack{
            Text(manager.currentDungeon.name).font(.headline)
            Text(manager.currentRoom.name)
            ValueProgressBar(value: manager.currentHp, max: manager.maxHp)
            
            // Cheat to update UI when a PlayerAction has been processed
            Text(socketServer.lastActionReceived?.tileId.uuidString ?? "").hidden()
            
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10){
                ForEach($currentRoom.tiles, id: \.id){ $tile in
                    // Bindings ?
                    TileView(tile: $tile)
                        .onTapGesture {
                            if !tile.isDisabled{
                                let result = tile.onTap(manager: manager) //Responsible for sending PlayerAction to server
                                messageNotification = result.message
                                errorNotification = result.error
                                
                                if let playerAction = result.action {
                                    socketServer.sendPlayerAction(playerAction)
                                }
                            }
                        }
                }
            }
            
            Spacer()
            navigationControls
        }.onAppear{
            if (manager.currentRoomId == nil){
                manager.currentRoomId = manager.currentDungeon.rooms[0].id
            }
        }.overlay(alignment: .top){
            QuickNotification(message: $messageNotification, fgColor: .white, bgColor: .lightGreen, duration: 2.0)
            QuickNotification(message: $errorNotification, fgColor: .white, bgColor: .red, duration: 2.0)
        }.toolbar{
            ToolbarItem(placement: .bottomBar){
                consumableMenu
            }
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink(destination: InventoryView()){
                    Image(systemName: "backpack")
                }
            }
            ToolbarItem(placement: .bottomBar){
                Button(action: {sheet = .map}){
                    Image(systemName: "map")
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink(destination: MultiplayerView()){
                    Image(systemName: "server.rack")
                }
            }
        }.sheet(item: $sheet){ sheet in
            switch(sheet){
            case .map:
                MapView().presentationDetents([.fraction(0.40)])
            }
        }.onChange(of: manager.currentHp){
            if(manager.currentHp < 0){
                manager.currentHp = manager.maxHp
                socketServer.socket.disconnect()
                manager.currentDungeon.resetEnemies()
                dismiss()
            }
        }
    }
    
    var navigationControls: some View {
        let room = manager.currentRoom
        
        return VStack{
            NavigationMoveButton(direction: .north, enabled: manager.currentDungeon.hasNeighbor(room: room, direction: .north))
            HStack{
                NavigationMoveButton(direction: .west, enabled: manager.currentDungeon.hasNeighbor(room: room, direction: .west))
                Spacer()
                NavigationMoveButton(direction: .east, enabled: manager.currentDungeon.hasNeighbor(room: room, direction: .east))
            }
            NavigationMoveButton(direction: .south, enabled: manager.currentDungeon.hasNeighbor(room: room, direction: .south))
        }.frame(width: 120, height: 120)
    }
    
    var consumableMenu: some View {
        SwiftUI.Menu{
            ForEach(manager.inventory.inventoryContent.slots.filter({$0.isConsumable})){ slot in
                Button(action: {
                    manager.useConsumable(slot.item_id); messageNotification = "You've used a(n) \(slot.item_id)"
                }){
                    Text("\(slot.quantity)x \(slot.item_id)(s)")
                }
            }
            if manager.inventory.inventoryContent.slots.filter({$0.isConsumable}).count == 0 {
                Text("No consumables")
            }
        } label: {
            Image(systemName: "carrot")
        }
    }
}

#Preview {
    @State var room = Room.genStandardRoom()
    @State var manager = Manager()
    return DungeonView(currentRoom: $room)
        .environment(SocketServer(manager: manager))
        .environment(manager)
}
