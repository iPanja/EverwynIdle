//
//  Inventory.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/20/23.
//

import SwiftUI

struct InventoryView: View {
    @Environment(Manager.self) var manager
    
    @State var selections = Set<String>()
    @State var editMode : EditMode = .inactive
    
    var body: some View {        
        Group{
            // Inventory
            List(selection: $selections){
                // Static
                Section("You"){
                    Text("Shards: \(manager.currency)")
                }
                
                playerEquipment
                
                // Dynamic
                Section("Inventory (\(manager.inventory.maxSlots) slots)"){
                    ForEach(manager.inventory.inventoryContent.slots, id: \.item_id){ slot in
                        HStack{
                            Text(String(slot.item_id))
                            Spacer()
                            Text(String(slot.quantity))
                        }
                    }.onDelete(perform: delete)
                    ListFootnote("Consider buying more inventory slots from the shop!")
                }
            }
            .navigationTitle("Inventory")
            .listStyle(.grouped)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar){
                    Button(action:{manager.inventory.removeSlots(slot_ids: selections)}) {
                        Image(systemName: "trash")
                    }.disabled(selections.isEmpty || editMode == .inactive)
                }
            }
        }.environment(\.editMode, $editMode)
    }
    
    func delete(at offsets: IndexSet) {
        manager.inventory.removeSlots(slotOffsets: offsets)
    }
    
    var playerEquipment: some View{
        Section("Equipment"){
            ForEach(manager.inventory.equipment.equipmentSlotTypes, id: \.rawValue){ slot_type in
                let binding = manager.getEquipmentBinding(itemType: slot_type)
                EquipmentPicker(selection: binding, slotType: slot_type).selectionDisabled()
            }
        }
    }
}

#Preview {
    InventoryView().environment(Manager())
}
