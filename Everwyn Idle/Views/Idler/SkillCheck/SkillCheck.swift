//
//  GameTest.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/18/23.
//

import SwiftUI

struct SkillCheck: View {
    @Binding var rotationDegrees: Double
    @Binding var game: SkillCheckGame
    
    @State var isSpinning: Bool = true
    
    static var speed: Double = 20
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            ZStack{
                SkillCheckCircle(difficulty: game.difficulty, rotation: .degrees(game.initialOffset))
                
                SkillCheckIndicator()
                    .offset(CGSize(width: 0, height: -50))
                    .rotationEffect(.degrees(rotationDegrees))
                    .onReceive(timer, perform: { _ in
                        if self.isSpinning{
                            rotationDegrees = (self.rotationDegrees + SkillCheck.speed).truncatingRemainder(dividingBy: 360)
                        }
                    })
            }
            
            //Button(action: {isSpinning.toggle(); rotationDegrees = fix}){
        }
    }
}

#Preview {
    @State var rotationDegrees: Double = 0.0
    
    return Group {
        SkillCheck(rotationDegrees: $rotationDegrees, game: .constant(SkillCheckGame.standard))
    }
    /* 360 * (1-0.15) + 180 + 15 */
}
