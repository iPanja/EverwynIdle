//
//  Everwyn_IdleApp.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/17/23.
//

import SwiftUI

@main
struct Everwyn_IdleApp: App {
    @State var manager: Manager
    @State var socketServer: SocketServer
    
    init() {
        let myManager = Manager()
        self._manager = State(initialValue: myManager)
        self._socketServer = State(initialValue: SocketServer(manager: myManager))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(manager)
                .environment(socketServer)
        }
    }
}
