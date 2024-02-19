//
//  Direction.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/30/23.
//

import Foundation
import SwiftUI

enum Direction: CaseIterable, Codable {
    case north
    case east
    case south
    case west
    
    var alignment: Alignment {
        switch (self){
        case .north:
            return .trailing
        case .east:
            return .trailing
        case .south:
            return .bottom
        case .west:
            return .leading
        }
    }
}

extension Direction{
    static func newPos(direction: Direction, row: Int, col: Int) -> (row: Int, col: Int){
        switch(direction){
        case .north:
            return (row-1, col)
        case .east:
            return (row, col+1)
        case .south:
            return (row+1, col)
        case .west:
            return (row, col-1)
        }
    }
}
