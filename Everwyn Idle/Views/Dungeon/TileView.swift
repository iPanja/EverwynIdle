//
//  TileView.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/26/23.
//

import SwiftUI

struct TileView: View {
    @Binding var tile: TileProtocol
    
    private let size: CGFloat = 120
    
    var body: some View {
        ZStack(alignment: .bottom){
            background
            border
            
            if !tile.isDisabled{
                content.padding()
            }
        }.overlay(alignment: .topTrailing){
            if let tile = tile as? EnemyTile{
                if tile.enemy.hp > 0 {
                    Text("(\(tile.enemy.hp)/\(tile.enemy.maxHealth))").font(.caption)
                        .padding([.top, .trailing], 5)
                }
            }
        }
        .frame(width: size, height: size)
        .cornerRadius(3.0)
    }
    
    var border: some View {
        Rectangle()
            .fill(.black.opacity(0))
            .border(.black, width: 2)
    }
    
    var background: some View{
        let primaryValue: CGFloat = tile.isDisabled ? 0.0 : tile.primaryValue
        
        return ZStack(alignment: .bottom){
            Rectangle()
                .fill(tile.secondaryColor)
                .frame(height: size)
            
            Rectangle()
                .fill(tile.primaryColor)
                .frame(height: primaryValue*size)
        }
    }
    
    var content: some View {
        return Group{
            Text(tile.name)
        }
    }
}

#Preview {
    TileView(tile: .constant(Tile.RandomTile()))
}
