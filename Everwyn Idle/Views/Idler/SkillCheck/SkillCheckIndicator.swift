//
//  SkillCheckIndicator.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import SwiftUI

struct SkillCheckIndicator: View {
    let thickness: CGFloat = 8
    
    var body: some View {
        Rectangle()
            .fill(Color.brightRed)
            .frame(width: thickness, height: thickness*4)
    }
}

#Preview {
    SkillCheckIndicator()
}
