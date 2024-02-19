//
//  View.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}
