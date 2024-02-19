//
//  ConnectorView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/30/23.
//

import SwiftUI

struct ConnectorView: View {
    var direction: Direction
    
    private let size: CGFloat = 40
    
    var body: some View {
        switch(direction){
        case .south:
            HStack{
                rect
                    .offset(x: 0, y: 20)
            }
        case .north:
            HStack{
                rect
                    .offset(x: 0, y: -20)
            }
        case .east:
            rect
                .rotationEffect(Angle(degrees: 90))
                .offset(x: 20, y: 0)
        case .west:
            rect
                .rotationEffect(Angle(degrees: 90))
                .offset(x: -20, y: 0)
        }
    }
    
    var rect: some View {
        Rectangle()
            .fill(.yellow)
            .frame(width: size/2, height: 2)
    }
}

#Preview {
    Group{
        RoomTileView(isActive: false, isCleared: false)
            .overlay{
            ConnectorView(direction: .north)
            ConnectorView(direction: .south)
            ConnectorView(direction: .west)
            ConnectorView(direction: .east)
        }
    }
}
