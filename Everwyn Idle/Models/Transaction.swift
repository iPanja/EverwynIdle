//
//  Transaction.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/3/23.
//

import Foundation

enum Transaction: String, Identifiable, CaseIterable{
    case buy = "Buy", sell = "Sell"
    
    var id: String { self.rawValue }
}
