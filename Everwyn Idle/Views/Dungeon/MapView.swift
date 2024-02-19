//
//  MapView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/30/23.
//

import SwiftUI

struct MapView: View {
    @Environment(Manager.self) var manager
    
    var body: some View {
        @Bindable var manager = manager
        
        VStack{
            Text("Dungeon View").font(.title)
            
            Spacer()
                        
            VStack(spacing: 0){
                ForEach($manager.currentDungeon.grid, id: \.self) { row in
                    HStack(spacing: 0){
                        ForEach(row, id: \.self){ $roomId in
                            if let roomId{
                                let room: Room = manager.currentDungeon.lookup(roomId)!
                                RoomTileView(isActive: roomId == manager.currentRoom.id, isCleared: room.isCleared)
                                    .overlay{
                                        ForEach(Array(manager.currentDungeon.getNeighbors(room).keys), id: \.self) { direction in
                                            ConnectorView(direction: direction)
                                        }
                                    }
                            }else{
                                Rectangle()
                                    .frame(width: 40, height: 40)
                                    .opacity(0)
                                    .tag(UUID())
                            }
                        }
                    }
                }
            }
            .border(.black, width: 2.0)
            .cornerRadius(3.0)
            .background(.gray)
        }.padding()
    }
}

#Preview {
    MapView().environment(Manager())
}
