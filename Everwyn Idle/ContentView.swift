//
//  ContentView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/17/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(Manager.self) var manager
        
    var body: some View {
        @Bindable var manager = manager
                
        VStack {
            NavigationStack{    
                List{
                    Section("You"){
                        Text("Shards: \(manager.currency)")
                        NavigationLink(destination: InventoryView() ){Text("Inventory")}
                    }
                    
                    Section("Skills"){
                        ForEach($manager.playerSkills){ $ps in
                            NavigationLink(destination: SkillView(playerSkill: $ps)){
                                PlayerSkillRow(playerSkill: $ps)
                            }
                        }
                    }
                    
                    Section("Locations"){
                        NavigationLink(destination: ShopView()){
                            Text("Shop")
                        }
                        NavigationLink(destination: dungeonView){
                            Text("Dungeon")
                        }
                        
                        Text("Elders of Eternity")
                    }
                }.navigationTitle("Everwyn Idle")
            }.overlay(alignment: .top){
                QuickNotification(message: $manager.httpServer.httpError, fgColor: .white, bgColor: .red, duration: 3.0)
            }
        }
    }
    
    var dungeonView: some View{
        return DungeonView(currentRoom: manager.getCurrentRoom())
    }
}

#Preview {
    ContentView().environment(Manager())
}
