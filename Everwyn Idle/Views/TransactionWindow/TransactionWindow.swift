//
//  TransactionWindow.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/3/23.
//

import SwiftUI

struct TransactionWindow: View {
    @Environment(Manager.self) var manager
    
    @State var name: String
    var mode: Transaction
    @Binding var inventory: InventoryContent
    
    @State var selectedSlot: Slot? = .none
    
    @State var futureTransactionQuantity: Int = 1
    
    @State var purchaseError: String? = .none
    @State var purchaseMessage: String? = .none
    
    var body: some View {
        Group{
            VStack(alignment: .leading){
                inventoryHeader
                inventoryDisplay
            }.overlay(alignment: .top){
                QuickNotification(message: $purchaseError, fgColor: .black, bgColor: .red, duration: 3.0)
                QuickNotification(message: $purchaseMessage, fgColor: .white, bgColor: .lightGreen, duration: 3.0)
            }
        }
        .sheet(item: $selectedSlot){ slot in
            TransactionQuantityPicker(quantity: $futureTransactionQuantity, max_quantity: slot.quantity, mode: mode, item_id: slot.item_id, onConfirm: {
                attemptAction(slot, quantity: futureTransactionQuantity)
                //attemptPurchase(slot, quantity: futureTransactionQuantity)
            }).presentationDetents([.fraction(0.3)])
        }
    }
    
    var inventoryHeader: some View {
        Group{
            Text("\(name)").font(.title).bold()
            HStack{
                Text(mode == .buy ? "Buying from" : "Selling from").font(.subheadline)
                Text(mode == .buy ? "\(name)" : "Your Inventory").font(.subheadline).bold()
                
            }
        }.padding([.leading])
    }
    
    var inventoryDisplay: some View {
        List(selection: $selectedSlot){
            ForEach(inventory.slots, id: \.item_id){ slot in
                HStack{
                    Text(String(slot.item_id))
                    Spacer()
                    HStack{
                        Spacer()
                        Text("$\(Item.lookup(slot.item_id)?.value ?? -1)")
                        if(mode == .sell){
                            Spacer()
                            Text("\t(\(slot.quantity)x)")
                        }
                    }.frame(width: 125)
                }
                .tag(slot)
                .onTapGesture {
                    onTap(slot: slot)
                }
            }
        }
    }
    
    func onTap(slot: Slot){
        selectedSlot = slot
    }
    
    func attemptPurchase(_ slot: Slot, quantity: Int){
        withAnimation{
            purchaseError = manager.purchaseProduct(item_id: slot.item_id, quantity: quantity)
            if purchaseError == .none{
                purchaseMessage = "You have purchased \(quantity) \(slot.item_id)s"
            }
        }
    }
    
    func attemptAction(_ slot: Slot, quantity: Int){
        withAnimation{
            if(mode == .buy){
                purchaseError = manager.purchaseProduct(item_id: slot.item_id, quantity: quantity)
                if purchaseError == .none{
                    purchaseMessage = "You have purchased \(quantity) \(slot.item_id)s"
                }
            }else{
                purchaseError = manager.sellProduct(item_id: slot.item_id, quantity: quantity)
                if purchaseError == .none{
                    purchaseMessage = "You have sold \(quantity) \(slot.item_id)s"
                }
            }
        }
    }
}

#Preview {
    TransactionWindow(name: "Teddy", mode: .buy, inventory: .constant(InventoryContent(slots: [Slot(item_id: "Steel Sword", quantity: 2)]))).environment(Manager())
}
