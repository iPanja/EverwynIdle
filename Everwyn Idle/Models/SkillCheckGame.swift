//
//  SkillCheckGame.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/1/23.
//

import Foundation

struct SkillCheckGame{
    // All variables are in degrees
    var difficulty: Double
    var initialOffset: Double = 0.0
    
    var endOffset: Double{
        return (90.0 + initialOffset).truncatingRemainder(dividingBy: 360)
    }
    
    var startOffset: Double{
        return (endOffset + (360 * (1-difficulty))).truncatingRemainder(dividingBy: 360)
    }
    
    func contains(degrees: Double) -> Bool{
        if startOffset > endOffset{ // Runs over from 360 -> 0
            return degrees > startOffset || degrees < endOffset
        }
        
        return degrees > startOffset*0.95 && degrees < endOffset*1.05 // Multipliers for wiggle room for the animation/timing method used
    }
    
    static var standard = SkillCheckGame(difficulty: 0.15, initialOffset: 60.0)
    
    static func random() -> SkillCheckGame {
        let difficulty = Double.random(in: 0.015..<0.35)
        let arcLen = 360 * (difficulty)
        let initialOffset = Double.random(in: 90..<(360-arcLen))
        
        return SkillCheckGame(difficulty: difficulty, initialOffset: initialOffset)
    }
}


