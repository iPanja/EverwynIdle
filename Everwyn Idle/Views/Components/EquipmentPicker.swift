//
//  DPicker.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/1/23.
//

import SwiftUI

struct EquipmentPicker: View {
    @Environment(Manager.self) var manager
    @Binding var selection: String?
    
    var slotType: ItemType
    
    var body: some View {
        Picker(slotType.rawValue, selection: $selection){
            Text("None").tag((String?).none)
            ForEach(manager.inventory.inventoryContent.slots, id: \.item_id){ slot in
                if(Item.item_type(slot.item_id) == slotType){
                    Text(String(slot.item_id)).tag(slot.item_id as String?)
                }
            }
        }
    }
}

#Preview {
    EquipmentPicker(selection: .constant("test"), slotType: .weapon).environment(Manager())
}
