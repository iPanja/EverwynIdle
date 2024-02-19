//
//  PlayerSkillProgressView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/19/23.
//

import SwiftUI

struct PlayerSkillProgressView: View {
    @Binding var playerSkill: PlayerSkill
    var mini: Bool = true
    
    var body: some View {
        let nlProgression = playerSkill.nextLevelProgression
        let nlFraction = String(Int(nlProgression * 100)) + "%"
        let nlDetailedFraction = playerSkill.nextLevelProgressionFS
        
        HStack{
            Text("Lvl " + String(playerSkill.level)).bold()
                .padding([.trailing], 10)
            ProgressView(value: nlProgression){
                HStack{
                    Text(nlFraction).font(.caption)
                    if !mini{
                        Spacer()
                        Text(nlDetailedFraction).font(.caption)
                    }
                }
            }.if(mini){
                $0.frame(width: 50)
            }
        }
    }
}

#Preview {
    VStack{
        PlayerSkillProgressView(playerSkill: .constant(.standard))
        PlayerSkillProgressView(playerSkill: .constant(.standard), mini: false)
    }
}
