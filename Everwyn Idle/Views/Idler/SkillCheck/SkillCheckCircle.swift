//
//  SkillCheck.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import SwiftUI

struct SkillCheckCircle: View {
    let difficulty: Double
    let rotation: Angle
    
    let circleThickness: CGFloat = 6
    let skillThickness: CGFloat = 14
    
    var body: some View {
        Circle()
            .stroke(Color.dBlack, lineWidth: circleThickness)
            .frame(width: 100, height: 100)
            .overlay{
                SkillCheckCircleShape(difficulty: difficulty)
                    .stroke(Color.dBlack, lineWidth: skillThickness)
                    .rotationEffect(rotation)
            }
    }
}

struct SkillCheckCircleShape: Shape{
    let difficulty: Double
    
    let radius: CGFloat = 50
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let angle = Angle(degrees: 360 * (1-difficulty))
        
        path.addArc(center: CGPoint(x: 0, y: 0), radius: radius, startAngle: .degrees(.zero), endAngle: angle, clockwise: true)
                
        return path.offsetBy(dx: radius, dy: radius)
    }
}

#Preview {
    SkillCheckCircle(difficulty: 0.15, rotation: .degrees(0))
}
