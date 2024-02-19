//
//  SkillLocationRow.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/19/23.
//

import SwiftUI

struct SkillLocationRow: View {
    @Environment(Manager.self) var manager
    
    let skillLocation: SkillLocation
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(skillLocation.name)
                Spacer()
                if !manager.isLocationUnlocked(skillLocation){
                    Image(systemName: "lock.fill")
                        .foregroundStyle(.yellow)
                }
            }
            if !manager.isLocationUnlocked(skillLocation){
                Text("Lvl \(skillLocation.requiredLevel) - \(skillLocation.unlockCost) coins").foregroundStyle(.red).font(.caption)
            }
            Text(skillLocation.description).font(.caption)
        }
    }
}

#Preview {
    SkillLocationRow(skillLocation: .catfishCove).environment(Manager())
}
