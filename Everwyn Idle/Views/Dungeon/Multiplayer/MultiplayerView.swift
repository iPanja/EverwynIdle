//
//  MultiplayerView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/7/23.
//

import SwiftUI

struct MultiplayerView: View {
    @Environment(SocketServer.self) var socketServer
    
    @State var isShowingSettings: Bool = false
    
    var body: some View {
        @Bindable var socketServer = socketServer
        
        Group{
            VStack{
                Text("Dungeon Co-Op").font(.title)
                
                controlsBox
                
                if socketServer.isInLobby{
                    lobbyPlayerView
                }else{
                    globalPlayerListView
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                namePickerMenu
            }
            ToolbarItem(placement: .topBarTrailing){
                Button(action: { isShowingSettings.toggle() }){
                    Image(systemName: "gearshape")
                }
            }
        }
        .overlay(alignment: .top){
            QuickNotification(message: $socketServer.notification, fgColor: .white, bgColor: .lightGreen, duration: 3.0)
        }
        .safeAreaInset(edge: .bottom){
            statusBox
        }
        .sheet(isPresented: $isShowingSettings){
            MultiplayerSettings().presentationDetents([.medium])
        }
    }
    
    var statusBox: some View {
        HStack{
            Text("Connection status: \(connectionString)")
            Button(action: {
                socketServer.reconnect()
            }){
                Image(systemName: "arrow.triangle.2.circlepath.circle")
            }
        }
    }
    
    var controlsBox: some View {
        HStack{
            Button(action: {
                socketServer.toggleLobby()
            }){
                Text(socketServer.isHosting ? "Close Lobby" : "Create Lobby")
            }
            .disabled(!socketServer.isHosting && socketServer.isInLobby)
            .padding([.trailing], 25)
                            
            Button(action: {
                socketServer.leaveLobby()
            }){
                Text("Leave Lobby")
            }
            .disabled(!socketServer.isInLobby || socketServer.isHosting)
        }.padding()
    }
    
    var globalPlayerListView: some View {
        return List(){
            Section("Lobbies"){
                ForEach(socketServer.globalPlayerList.sorted(by: >), id: \.key){ playerId, playerName in
                    HStack{
                        Button(action: {
                            socketServer.joinLobby(hostId: playerId)
                        }){
                            Text(playerName)
                                .foregroundStyle((socketServer.id == playerId) ? .gray : .black)
                        }
                        .disabled(socketServer.id == playerId)
                        .tag(playerId)
                    }
                }
                if(socketServer.globalPlayerList.count == 0){
                    Text("No open lobbies")
                }
                
                ListFootnote("\(socketServer.name) (\(socketServer.id))")
            }
        }
    }
    
    var lobbyPlayerView: some View {
        return List(){
            Section("Your Lobby"){
                ForEach(socketServer.lobbyList.sorted(by: >), id: \.key){ playerId, playerName in
                    HStack{
                        Text(getPlayerText(playerId, playerName))
                    }
                }
                ListFootnote("\(socketServer.name) (\(socketServer.id))")
            }
        }
    }
    
    var namePickerMenu: some View {
        Menu{
            ForEach(SocketServer.names){ name in
                Button(action: {
                    socketServer.updateName(name)
                }){
                    Text(name);
                }
            }
        } label: {
            Text(socketServer.name)
        }.disabled(socketServer.isNameLocked)
    }
}


// Helper Methods
extension MultiplayerView {
    var connectionString: String {
        socketServer.isConnected() ? "Connected" : "Disconnected"
    }
    
    func getPlayerText(_ playerId: String, _ playerName: String) -> String{
        var text = "\(playerName)"
        
        if playerId == socketServer.id {
            text += " (You)"
        }
        if playerId == socketServer.lobbyHostId {
            text += " (Host)"
        }
        
        return text
    }
}

#Preview {
    return MultiplayerView()
        .environment(SocketServer(manager: Manager()))
}
