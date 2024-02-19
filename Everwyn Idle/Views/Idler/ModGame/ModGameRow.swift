//
//  ModGameRow.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/6/23.
//

import SwiftUI

struct ModGameRow: View {
    @Binding var value: Bool?
    @State var locked = false
    let gameUUID: UUID
    
    private static let base = 5
    
    @State private var x = Int.random(in: 0...base)
    @State private var y = Int.random(in: 0...base)
    @State private var isAddition = Bool.random()
    
    var body: some View {
        HStack{
            ForEach((0...ModGameRow.base-1), id: \.self){ i in
                Button(action: {
                    onTap(i)
                }){
                    Text(String(i))
                }
                Spacer()
            }
                        
            Text("| \(x) \(operationSymbol) \(y) | mod \(ModGameRow.base)").bold()
                .foregroundStyle(value == true ? .green : (locked ? .red : .black))
                .frame(width: 125)
        }.onChange(of: gameUUID){
            newGame()
        }
        .padding()
        .disabled(locked)
    }
    
    func onTap(_ response: Int) {
        value = (response == solution) as Bool?
        locked = true
    }
    
    var operationSymbol: String {
        isAddition ? "+" : "-"
    }
    
    var solution: Int {
        return (isAddition ? abs(x+y) : abs(x-y)) % ModGameRow.base
    }
    
    func newGame(){
        x = Int.random(in: 0...ModGameRow.base)
        y = Int.random(in: 0...ModGameRow.base)
        isAddition = Bool.random()
        locked = false
    }
}

#Preview {
    ModGameRow(value: .constant(false), gameUUID: UUID())
}
