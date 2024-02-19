//
//  ShopView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/20/23.
//

import SwiftUI

struct ShopView: View {
    @Environment(Manager.self) var manager
    @State private var selection: String = "Woodsman Wilber"
    @State private var mode: Transaction = .buy
    
    var body: some View {
        Group{
            ScrollView{
                LazyHStack{
                    TabView(selection: $selection){
                        ForEach(Merchant.allMerchants){ merchant in
                            pageView(merchant: merchant).tag(merchant.id)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .tabViewStyle(PageTabViewStyle())
                }
            }
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    ScrollViewReader{ value in
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(Merchant.allMerchants){ merchant in
                                    Button(action: {
                                        withAnimation{
                                            selection = merchant.id
                                            value.scrollTo(merchant.id)
                                        }
                                    }){
                                        Text(merchant.name).bold(selection == merchant.id)
                                    }.id(merchant.id)
                                }.padding()
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    modePicker
                }
            }
            .navigationTitle("Shop")
        }
    }
    
    func pageView(merchant: Merchant) -> some View {
        if(mode == .buy){
            var inventory = merchant.inventory
            inventory.slots.append(contentsOf: manager.getAdditionalItemsForSale(merchantId: merchant.id))
            
            return TransactionWindow(name: merchant.name, mode: .buy, inventory: .constant(inventory))
        }else{
            return TransactionWindow(name: merchant.name, mode: .sell, inventory: .constant(manager.inventory.inventoryContent))
        }
    }
    
    var modePicker: some View {
        Picker("Mode", selection: $mode){
            ForEach(Transaction.allCases){ m in
                Text(m.rawValue).tag(m)
            }
        }.pickerStyle(.segmented)
    }
}

#Preview {
    ShopView().environment(Manager())
}
