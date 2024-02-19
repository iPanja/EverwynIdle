//
//  DropTableView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/6/23.
//

import SwiftUI

struct DropTableView: View {
    var location: SkillLocation
    
    var body: some View {
        List{
            Section("Drop Table"){
                ForEach(location.productTable.sorted(by: {
                    if $0.value == $1.value{
                        return $0.key < $1.key
                    }
                    return $0.value > $1.value
                }), id: \.key){ entry in
                    HStack{
                        Text(entry.key)
                        Spacer()
                        Text(String(format: "%.0f", entry.value) + "%")
                    }
                }
            }
        }
    }
}

#Preview {
    DropTableView(location: .beginnersGrove)
}
