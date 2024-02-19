//
//  TransactionQuantityPicker.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/3/23.
//

import SwiftUI

struct TransactionQuantityPicker: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var quantity: Int
    let max_quantity: Int
    let mode: Transaction
    let item_id: String
    
    var onConfirm: () -> Void
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Select the Quantity").font(.title)
                Slider(value: .init(get: {Double(quantity)}, set: {quantity = Int($0)}), in: 0...Double(max_quantity), step: 1){
                    Text("Quantity")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text(String(max_quantity))
                }
                
                Text("x\(quantity) ($\(cost * quantity))")
                Spacer()
                Button(action: {onConfirm(); dismiss()}){
                    Text(mode == .buy ? "Purchase" : "Sell")
                }.buttonStyle(.borderedProminent)
            }
            .padding()
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {dismiss()}){
                        Text("Dismiss")
                    }
                }
            }
        }
        
    }
    
    var cost: Int {
        (Item.lookup(item_id)?.value ?? -1)
    }
}

#Preview {
    @State var quantity: Int = 1
    return TransactionQuantityPicker(quantity: $quantity, max_quantity: 5, mode: .buy, item_id: "Steel Sword", onConfirm: {})
}
