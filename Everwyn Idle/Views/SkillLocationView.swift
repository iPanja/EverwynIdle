//
//  SkillLocationView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/19/23.
//

import SwiftUI

struct SkillLocationView: View {
    @Environment(Manager.self) var manager
    
    @State var location: SkillLocation
    @State var isShowingDropTable = false
    
    var body: some View {
        let psb = manager.getPlayerSkill(location.skillType)
        
        VStack{
            PlayerSkillProgressView(playerSkill: psb, mini: false)
                .padding()
            LocationIdlerMain(location: location)
            
            Spacer()
        }.toolbar{
            NavigationLink(destination: InventoryView()){
                Image(systemName: "backpack")
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    isShowingDropTable.toggle()
                }){
                    Image(systemName: "tray.full")
                }
            }
        }
        .sheet(isPresented: $isShowingDropTable, content: {
            DropTableView(location: location).presentationDetents([.medium])
        })
    }
}

#Preview {
    SkillLocationView(location: .beginnersGrove).environment(Manager())
}
