//
//  SkillRow.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import SwiftUI

struct PlayerSkillRow: View {
    @Binding var playerSkill: PlayerSkill
    
    var body: some View {
        HStack{
            Text(playerSkill.name)
            Spacer()
            PlayerSkillProgressView(playerSkill: $playerSkill)
        }.padding([.trailing])
    }
}

#Preview {
    PlayerSkillRow(playerSkill: .constant(PlayerSkill.standard))
}
