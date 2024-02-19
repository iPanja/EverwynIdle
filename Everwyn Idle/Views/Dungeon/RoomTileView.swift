//
//  RoomTileView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/30/23.
//

import SwiftUI

struct RoomTileView: View {
    var isActive: Bool
    var isCleared: Bool
    
    private let size: CGFloat = 40
    
    var body: some View {
        ZStack(alignment: .bottom){
            background
            border
        }
        .frame(width: size, height: size)
        .cornerRadius(3.0)
    }
    
    var border: some View {
        Rectangle()
            .fill(.black.opacity(0))
            .border(isActive ? Color.blue : .black, width: 2)
    }
    
    var background: some View {
        return ZStack(alignment: .bottom){
            Rectangle()
                .fill(isCleared ? Color.dBlack : Color.dGray)
                .frame(height: size)
        }
    }
    
    var topConnector: some View {
        Rectangle()
            .fill(.red)
            .frame(width: size/2, height: 2)
    }
}

#Preview {
    RoomTileView(isActive: false, isCleared: false)
}
