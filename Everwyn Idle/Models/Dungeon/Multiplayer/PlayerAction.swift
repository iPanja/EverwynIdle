//
//  PlayerAction.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/8/23.
//

import Foundation

struct PlayerAction: Codable {
    var type: ActionType
    var tileId: UUID
    
    var damageAmount: Int?
}
