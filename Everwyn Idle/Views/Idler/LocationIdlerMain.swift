//
//  LocationIdler.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/19/23.
//

import SwiftUI

struct LocationIdlerMain: View {
    @Environment(Manager.self) var manager
    
    var location: SkillLocation
    
    @State var game: SkillCheckGame = .standard
    @State var rd: Double = .zero
    @State var idlerOption: IdlerMode = .circle
    
    @State var gameUUID = UUID()
    
    @State var notification: String? = .none
    @State var ets: String? = .none
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var result: Bool? = .none
    
    var body: some View {
        
        VStack{
            idlerPicker
            
            Spacer()
            
            switch(idlerOption){
            case .circle:
                circleIdler
            case .idler:
                actualIdler
            case .modgame:
                modIdler
            }
            
            Spacer()
        }.overlay(alignment: .top){
            QuickNotification(message: $notification, fgColor: .white, bgColor: .lightGreen, duration: 3.0)
        }
    }
    
    /* Not used at the moment
    var fix: Double{
        return (rd - 1.25*SkillCheck.speed).truncatingRemainder(dividingBy: 360)
    }
    */
    
    var idlerPicker: some View{
        Picker("Game", selection: $idlerOption){
            ForEach(IdlerMode.allCases){ m in
                Text(m.rawValue).tag(m)
            }
        }.pickerStyle(.segmented)
    }
    
    var circleIdler: some View{
        VStack{
            SkillCheck(rotationDegrees: $rd, game: $game)
                .navigationTitle(location.name)
            Button(action: {
                onCompletion(result: game.contains(degrees: rd))
                game = .random();
            }){
                Text("Stop").bold()
            }.buttonStyle(.borderedProminent).padding([.top])
        }
    }
    
    var modIdler: some View{
        return VStack {
            ModGameView(result: $result, gameUUID: gameUUID).onChange(of: result){
                if result != .none{
                    onCompletion(result: result == true)
                    result = .none
                }
                gameUUID = UUID()
            }
            .navigationTitle(location.name)
            
            Button(action: {
                gameUUID = UUID()
            }){
                Text("Reset")
            }.buttonStyle(.borderedProminent)
        }
    }
    
    var actualIdler: some View{
        VStack{
            HStack{
                Text("Status: ")
                Text(manager.currentIdle == nil ? "not idling" : "idling").bold()
                if let ets{
                    Text(ets)
                }
            }.navigationTitle(location.name)
            
            if let idle = manager.currentIdle{
                Text("@ \(idle.locationId)")
            }
            
            Button(action: {
                notification = manager.toggleIdle(location)
            }){
                Text(buttonText)
            }.buttonStyle(.borderedProminent).padding([.top])
        }.onReceive(timer, perform: { _ in
            ets = calc_ets
        })
    }
    
    var buttonText: String{
        if let idle = manager.currentIdle {
            if idle.locationId == location.id{
                return "Stop Idling"
            }
            return "Begin Idling Here"
        }
        return "Begin Idling"
    }
    
    var calc_ets: String?{
        if let idle = manager.currentIdle{
            return manager.elapsedTimeString(date: idle.startDate)
        }
        return .none
    }
    
    func onCompletion(result: Bool){
        if result == true {
            manager.rewardPlayer(location)
            notification = "Good job!"
        }else if result == false {
            notification = "Uh oh!"
        }
    }
}

#Preview {
    LocationIdlerMain(location: .beginnersGrove, idlerOption: .modgame).environment(Manager())
}
