//
//  NavigationMoveButton.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/27/23.
//

import SwiftUI

struct NavigationMoveButton: View {
    @Environment(Manager.self) var manager
    
    let direction: Direction
    let enabled: Bool
    
    var body: some View {
        Button(action: {
            withAnimation(.linear){
                manager.moveDirection(direction)
            }
        }){
            Image(systemName: imageName).font(.title)
                .disabled(!enabled)
        }
    }
    
    var imageName: String {
        switch direction {
            case .north:
                return "arrowshape.up"
            case .east:
                return "arrowshape.right"
            case .south:
                return "arrowshape.down"
            case .west:
                return "arrowshape.left"
        }
    }
}

#Preview {
    NavigationMoveButton(direction: .east, enabled: false)
        .environment(Manager())
}
