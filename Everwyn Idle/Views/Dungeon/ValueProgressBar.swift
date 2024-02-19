//
//  ValueProgressBar.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/30/23.
//

import SwiftUI

struct ValueProgressBar: View {
    var value: Int
    var max: Int
    
    var body: some View {
        HStack{
            Text("HP").bold()
            
            ProgressView(value: Double(value)/Double(max)){}
            
            Text("\(Int(100*Double(value)/Double(max)))%")
        }.padding()
    }
}

#Preview {
    ValueProgressBar(value: 80, max: 100)
}
