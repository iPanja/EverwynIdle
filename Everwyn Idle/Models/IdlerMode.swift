//
//  IdlerGames.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/19/23.
//

import Foundation

enum IdlerMode: String, Identifiable, CaseIterable{
    case circle = "Spinner", idler = "Idler", modgame = "Mod Game"
    
    var id: String { self.rawValue }
}
