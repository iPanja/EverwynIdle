//
//  SkillView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/19/23.
//

import SwiftUI

struct SkillView: View {
    @Environment(Manager.self) var manager
    
    @Binding var playerSkill: PlayerSkill
    
    @State var selectedUnlockLocation: SkillLocation? = .none
    @State var isShowingUnlockAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            PlayerSkillProgressView(playerSkill: $playerSkill, mini: false)
                .padding([.top], 1)
        }.padding([.leading, .trailing])
        
        NavigationStack{
            List{
                Section("Skill Locations"){
                    ForEach(SkillLocation.allLocations.filter({$0.skillType == playerSkill.type})){ loc in
                        if manager.isLocationUnlocked(loc){
                            NavigationLink(destination: SkillLocationView(location: loc)){
                                SkillLocationRow(skillLocation: loc).padding([.trailing])
                            }
                        }else{
                            Button(action: {selectedUnlockLocation=loc; isShowingUnlockAlert.toggle()}){
                                SkillLocationRow(skillLocation: loc)
                            }.foregroundStyle(.primary)
                        }
                    }
                }
            }.navigationTitle(playerSkill.name)
        }.toolbar{
            NavigationLink(destination: InventoryView()){
                Image(systemName: "backpack")
            }
        }
        .alert(
                "Unlock location?",
                isPresented: $isShowingUnlockAlert,
                presenting: selectedUnlockLocation
            ) { loc in
                if(manager.canUnlockLocation(selectedUnlockLocation!)){
                    Button {
                        manager.unlockLocation(selectedUnlockLocation!)
                    } label: {
                        Text("Unlock")
                    }
                }
                
                Button(role: .cancel) {
                    // Do nothing...
                } label: {
                    Text("Cancel")
                }
            } message: { loc in
                Text("\(loc.name) will cost you \(loc.unlockCost) shards, and you must be at least level \(loc.requiredLevel)!")
            }
    }
}

#Preview {
    SkillView(playerSkill: .constant(PlayerSkill.standard)).environment(Manager())
}
