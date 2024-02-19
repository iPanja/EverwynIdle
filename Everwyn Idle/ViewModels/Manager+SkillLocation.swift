//
//  Manager+SkillLocation.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 10/19/23.
//

import Foundation

extension Manager{
    func isLocationUnlocked(_ loc: SkillLocation) -> Bool{
        if let playerSkill = self.playerSkills.first(where: {$0.type == loc.skillType}){
            return playerSkill.isUnlocked(location: loc)
        }
        return false
    }
    
    func rewardPlayer(_ loc: SkillLocation){
        (0...playerSkills.count-1).forEach{ i in
            if playerSkills[i].type == loc.skillType{
                playerSkills[i].experience += 5
                let rewardItemID = loc.randomReward()
                self.inventory.addItem(itemId: rewardItemID)
                
                return
            }
        }
    }
    
    func unlockLocation(_ loc: SkillLocation) -> Bool{
        if(canUnlockLocation(loc)){
            //currency -= loc.unlock_cost
            
            (0...playerSkills.count-1).forEach{ i in
                if playerSkills[i].type == loc.skillType{
                    playerSkills[i].unlockedLocations.insert(loc.id)
                }
            }
            
            
            saveData()
            return true
        }
        return false
    }
    
    func canUnlockLocation(_ loc: SkillLocation) -> Bool{
        return currency >= loc.unlockCost && playerSkills.first(where: {$0.type == loc.skillType})?.level ?? -1 >= loc.requiredLevel
    }
    
    func toggleIdle(_ loc: SkillLocation) -> String{
        var result = ""
        
        if let idle = currentIdle{
            // Cash out current idle
            let elapsed = idle.startDate.timeIntervalSinceNow
            let minutes = Int((elapsed.truncatingRemainder(dividingBy: 3600)) / 60)
            
            if let cloc = SkillLocation.allLocations.first(where: {$0.id == idle.locationId}){
                for _ in 0..<abs(minutes) {
                    rewardPlayer(cloc)
                }
            }else{
                return "Error, could not find location!"
            }
            
            if idle.locationId != loc.id{
                // After cashing out old idle, begin new one at this new location
                currentIdle = idleData(locationId: loc.id, startDate: Date())
                result += "Cashed out previous\nBegin idling at \(loc.name)!"
            }else{
                result += "Done, check your inventory for your rewards!"
                currentIdle = .none
            }
            
            if abs(minutes) <= 0 {
                result = "You did not idle long enough to get any rewards!"
            }
        }else{
            // Start idle
            currentIdle = idleData(locationId: loc.id, startDate: Date())
            result = "Started idling at \(loc.name)!"
        }
        
        return result
    }
    
    func elapsedTimeString(date: Date) -> String{
        let elapsed = date.timeIntervalSinceNow
        
        let days = abs(Int(elapsed / (3600 * 24)))
        let hours = abs(Int((elapsed.truncatingRemainder(dividingBy: (3600 * 24))) / 3600))
        let minutes = abs(Int((elapsed.truncatingRemainder(dividingBy: 3600)) / 60))
        let seconds = abs(Int(elapsed.truncatingRemainder(dividingBy: 60)))
        
        var result = ""
        
        if days > 0{
            result += "\(days) Days, "
        }
        if hours > 0{
            result += "\(hours) Hours, "
        }
        if minutes > 0 {
            result += "\(minutes) Minutes, "
        }
        
        result += "\(seconds) Seconds"
        
        return result
    }
}
