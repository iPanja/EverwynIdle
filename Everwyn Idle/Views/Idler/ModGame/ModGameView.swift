//
//  ModGameView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/6/23.
//

import SwiftUI

struct ModGameView: View {
    @Binding var result: Bool?
    let gameUUID: UUID
    
    private static let rows = 8
    @State private var results: [Bool?] = Array(repeating: .none, count: ModGameView.rows)
    
    var body: some View {
        VStack{
            ForEach((0...ModGameView.rows-1), id: \.self){ i in
                ModGameRow(value: $results[i], gameUUID: gameUUID)
            }
        }.onChange(of: results){
            if(results.allSatisfy({$0 != Bool?.none})){ // All rows done
                result = !results.contains(false)
            }
        }.onChange(of: gameUUID){
            results = Array(repeating: .none, count: ModGameView.rows)
        }
    }
}

#Preview {
    @State var result: Bool? = .none
    return ModGameView(result: $result, gameUUID: UUID())
}
