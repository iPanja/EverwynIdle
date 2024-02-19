//
//  SocketServer.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/7/23.
//

import Foundation
import SocketIO

@Observable
class SocketServer {
    // Manager
    private var manager: Manager
    
    // Connection
    static var isLocal = false
    static var serverAddress: String = isLocal ? "http://localhost:3000" : "http://100.64.15.138:3000"
    //static var serverAddress: String = isLocal ? "http://localhost:3000" : "http://104.39.46.72:3000"
    
    // Setup
    var socketManager: SocketManager
    var socket: SocketIOClient
    
    var id: String = UUID().uuidString
    var name = names.randomElement()!
    
    // For UI
    var notification: String?
    var lastActionReceived: PlayerAction? // to trigger UI updates

    // Current Session Data
    //var isConnected: Bool = false
    func isConnected() -> Bool { return socket.status == .connected }
    var isHosting: Bool = false
    var isInLobby: Bool = false
    var globalPlayerList: [String: String] = [:] // [ID : player name]
    var lobbyList: [String: String] = [:] // [player ID : player name]
    var lobbyHostId: String = "" // id of host
    
    init(manager: Manager) {
        // Sockets
        self.manager = manager
        
        let _sm = SocketServer.createSocket(isLocal: SocketServer.isLocal, serverAddress: SocketServer.serverAddress)
        self.socketManager = _sm
        self.socket = _sm.defaultSocket
        
        addHandlers()
        connect()
    }
    
    static func createSocket(isLocal: Bool, serverAddress: String) -> SocketManager {
        let addr = isLocal ? "http://localhost:3000" : serverAddress
        return SocketManager(socketURL: URL(string: addr)!, config: [.log(false), .compress])
    }
    
    func recreateConnection(isLocal: Bool, serverAddress: String){
        let _sm = SocketServer.createSocket(isLocal: isLocal, serverAddress: serverAddress)
        self.socketManager = _sm
        self.socket = _sm.defaultSocket
        
        addHandlers()
        connect()
    }
    
    func connect(){ socket.connect() }
    
    func reconnect() { socket.connect() }
    
    func addHandlers() {
        socketManager.defaultSocket.on(clientEvent: .connect){ data, ack in
            self.socketManager.defaultSocket.emit("connection")
        }
        
        socketManager.defaultSocket.on(clientEvent: .disconnect){ data, ack in
            self.notification = "Lost connection..."
        }
        
        socketManager.defaultSocket.on(clientEvent: .reconnectAttempt){ data, ack in }
        
        socketManager.defaultSocket.on("updatePlayerList") { data, ack in
            self.updatedPlayerList(data: data)
        }
        
        socketManager.defaultSocket.on("playerJoinedGame"){ data, ack in
            self.playerJoinedGame(data: data)
        }
        
        socketManager.defaultSocket.on("playerLeftGame"){ data, ack in
            self.playerLeftGame(data: data)
        }
        
        socketManager.defaultSocket.on("lobbyClosed"){ data, ack in
            self.notification = "Your lobby has been closed"
            self.leaveLobby(pingServer: false)
        }
        
        socketManager.defaultSocket.on("requestDungeonState"){ data, ack in
            self.sendServerDungeonState(ack: ack)
        }
        
        socketManager.defaultSocket.on("dungeonState"){ data, ack in
            self.onReceivedDungeonState(data: data)
        }
        
        socketManager.defaultSocket.on("playerAction"){ data, ack in
            self.onReceivePlayerAction(data: data)
        }
    }
    
    func toggleLobby() {
        if isHosting {
            socket.emit("stopLookingForGame", self.id)
            isInLobby = false
        }else{
            socket.emit("lookingForGame", self.name, self.id)
            isInLobby = true
            lobbyList[id] = name
            lobbyHostId = id
        }
        isHosting.toggle()
    }
    
    func processPlayerList(_ playerList: [String: [String: String]]) -> [String: String]{
        var _dict:[String: String] = [:] // id -> name
        
        _dict = playerList.reduce(into: [String: String]()){ dict, entry in
            let playerData: [String: String] = entry.value
            if let name = playerData["name"] {
                dict[entry.key] = name
            }
        }
        
        return _dict
    }
    
    func updatedPlayerList(data: [Any]){
        if let playerList = data.first as? [String: [String: String]] {
            self.globalPlayerList = processPlayerList(playerList)
        }
    }
    
    // You are attempting to join a lobby
    func joinLobby(hostId: String){
        socket.emitWithAck("joinGame", with: [hostId, self.name, self.id]).timingOut(after: 2){ data in
            if let data = data.first as? [String: Any] {
                if let status = data["status"] as? String, let hostId = data["hostId"] as? String, let playerData = data["players"] as? [String: [String: String]] {
                    if status == "ok" {
                        self.isInLobby = true
                        
                        self.lobbyHostId = hostId
                        self.lobbyList = self.processPlayerList(playerData)
                    }
                }
            }
            
            if self.isInLobby {
                self.notification = "You have joined their lobby!"
                self.isInLobby = true
            }else{
                self.notification = "Failed to join their lobby"
                self.isInLobby = false
            }
        }
    }
    
    func leaveLobby(pingServer: Bool = true){
        if pingServer {
            self.socketManager.defaultSocket.emit("leaveGame", lobbyHostId, id)
        }
        
        isInLobby = false
        lobbyList = [:]
        lobbyHostId = ""
    }
    
    // Someone has joined your lobby
    func playerJoinedGame(data: [Any]){
        if let playerName = data[0] as? String, let playerId = data[1] as? String {
            notification = "\(playerName) has joined your lobby!"
            lobbyList[playerId] = playerName
        }
    }
    
    // Someone has left your lobby
    func playerLeftGame(data: [Any]){
        if let playerId = data[0] as? String, let playerName = data[1] as? String {
            notification = "\(playerName) has left your lobby!"
            lobbyList.removeValue(forKey: playerId)
        }
    }
    
    // Send the current dungeon state (as the host) to the server
    func sendServerDungeonState(ack: SocketAckEmitter){
        // (We are the host)
        // Send back dungeon state
        if let encodedState = self.dungeonStringEncoding() {
            ack.with(encodedState)
        }else{
            print("Failed to encode dungeon state!")
            notification = "Failed to encode dungeon state!"
        }
    }
    
    // Received dungeon state (after/while joining lobby)
    func onReceivedDungeonState(data: [Any]){
        if let encodedState = data.first as? String {
            if let hostDungeon = self.decodeDungeonEncoding(encoding: encodedState){
                manager.currentDungeon = hostDungeon
                manager.currentRoomId = manager.currentDungeon.rooms[0].id
                notification = "Synced dungeon from host!"
            }else{
                print("Failed to parse dungeon JSON")
            }
        }else{
            print("Failed to parse response sent from server")
        }
    }
    
    // Send player action to server (when tile is tapped)
    func sendPlayerAction(_ action: PlayerAction){
        if socket.status == .connected{
            if let actionEncoding = encodeAction(action) {
                socket.emit("sendPlayerAction", lobbyHostId, id, actionEncoding)
            }
        }
    }
    
    // Received player action from server
    func onReceivePlayerAction(data: [Any]){
        if let encodedAction = data.first as? String {
            if let playerAction = decodeAction(encodedAction) {
                manager.processPlayerAction(playerAction)
                self.lastActionReceived = playerAction // Used to trigger a UI redraw
            }else{
                print("Failed to decode player action")
            }
        }else{
            print("Failed to parse response sent from server")
        }
    }
}


extension SocketServer {
    static var names = [
        "Alpha",
        "Bravo",
        "Charlie",
        "Delta",
        "Echo",
        "Foxtrot",
        "Golf",
        "Hotel",
        "India",
        "Juliet",
        "Kilo",
        "Lima",
        "Mike",
        "November",
        "Oscar",
        "Papa",
        "Quebec",
        "Romeo",
        "Sierra",
        "Tango",
        "Uniform",
        "Victor",
        "Whiskey",
        "X-ray",
        "Yankee",
        "Zulu"
    ]
    
    func updateName(_ name: String){
        self.name = name
        // TODO: CALL SERVER
    }
    
    var isNameLocked: Bool {
        self.isInLobby || self.isHosting
    }
}

extension SocketServer {
    func dungeonStringEncoding() -> String? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(manager.currentDungeon)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("catch")
        }
        
        print("no error")
        return .none
    }
    
    func decodeDungeonEncoding(encoding: String) -> Dungeon? {
        do {
            let decoder = JSONDecoder()
            if let jsonData = encoding.data(using: .utf8) {
                let decodedDungeon = try decoder.decode(Dungeon.self, from: jsonData)
                return decodedDungeon
            }
        } catch {
            print("Error decoding Dungeon: \(error)")
            notification = error.localizedDescription
        }
        
        return .none
    }
    
    func encodeAction(_ action: PlayerAction) -> String? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(action)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
            print("catch")
        }
        
        print("no error")
        return .none
    }
    
    func decodeAction(_ encoding: String) -> PlayerAction? {
        do {
            let decoder = JSONDecoder()
            if let jsonData = encoding.data(using: .utf8) {
                let decodedAction = try decoder.decode(PlayerAction.self, from: jsonData)
                return decodedAction
            }
        } catch {
            print("Error decoding Player Action: \(error)")
            notification = error.localizedDescription
        }
        print("no error???")
        return .none
    }
}
