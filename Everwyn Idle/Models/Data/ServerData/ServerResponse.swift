//
//  ServerResponse.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/5/23.
//

import Foundation

struct MerchantEntry: Codable {
    var name: String
    var slots: [String]
}

struct ServerResponse: Codable {
    var merchants: [MerchantEntry]
}
