//
//  MultiplayerSettings.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/9/23.
//

import SwiftUI

struct MultiplayerSettings: View {
    @Environment(SocketServer.self) var socketServer
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("isLocal") private var isSocketServerLocal: Bool = false
    @AppStorage("socketServerAddress") private var socketServerAddress: String = "http://100.64.15.138:3000"
    
    var body: some View {
        Form {
            Section{
                Toggle("Is Socket Server Local?", isOn: $isSocketServerLocal)
                TextField("Socket Server IP", text: $socketServerAddress)
                    .disabled(isSocketServerLocal)
                    .textInputAutocapitalization(.never)
                    .foregroundStyle(isSocketServerLocal ? .gray : .blue)
            }header: {
                Text("Connection settings")
            }
                
            Section{
                Button(action: {
                    overrideSettings()
                    dismiss()
                }){
                    Text("Establish Connection")
                }
            }
        }.navigationTitle("Multiplayer Settings")
    }
    
    func overrideSettings() {
        socketServer.recreateConnection(isLocal: isSocketServerLocal, serverAddress: socketServerAddress)
    }
}

#Preview {
    MultiplayerSettings().environment(SocketServer(manager: Manager()))
}
