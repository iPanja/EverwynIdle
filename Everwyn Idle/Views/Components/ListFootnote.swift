//
//  ListFootnote.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/20/23.
//

import SwiftUI

struct ListFootnote: View {
    let string: String
    
    init(_ string: String) {
        self.string = string
    }
    
    var body: some View {
        Text(string)
            .font(.footnote)
            .listRowBackground(Color.clear)
    }
}

/*
#Preview {
    ListFootnote("TEST")
}
*/
