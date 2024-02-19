//
//  Dungeon.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 11/26/23.
//

import Foundation

struct Dungeon: Codable {
    var name: String
    var rooms: [Room] = []
    var grid: [[UUID?]] = []
    private var connections: [UUID: [Direction: UUID]] = [:]
    
    mutating func addRoom(_ room: Room){
        rooms.append(room)
        connections[room.id] = [:]
    }
    
    func getNeighbors(_ room: Room) -> [Direction: UUID]{
        if let n = connections[room.id]{
            return n
        }
        
        return [:]
    }
    
    mutating func addConnection(from sourceRoom: Room, direction sourceDirection: Direction, to destinationRoom: Room){
        guard connections[sourceRoom.id] != nil else {print ("ERROR CONNECTIONS"); return}
        
        connections[sourceRoom.id]![sourceDirection] = destinationRoom.id
        connections[destinationRoom.id]![Dungeon.oppositeDirection(sourceDirection)] = sourceRoom.id
    }
    
    static func oppositeDirection(_ direction: Direction) -> Direction {
        switch direction {
            case .north:
                return .south
            case .east:
                return .west
            case .south:
                return .north
            case .west:
                return .east
        }
    }
    
    func hasNeighbor(room: Room, direction: Direction) -> Bool {
        let neighbors: [Direction: UUID] = getNeighbors(room)
        if neighbors.count > 0 {
            if (neighbors[direction] != nil) {
                return true
            }
        }
        return false
    }
    
    func lookup(_ roomId: UUID) -> Room? {
        return rooms.first(where: {$0.id == roomId})
    }
    
    var columns: Int {
        var freq: [Int: Bool] = [:]

        for row in 0..<grid.count {
            for col in 0..<grid[row].count {
                if let _ = grid[row][col] {
                    freq[col] = true
                }
            }
        }

        return freq.count
    }
    
    // Heal damaged enemies, leave dead ones dead
    mutating func resetEnemies() {
        for i in 0..<rooms.count {
            for j in 0..<rooms[i].tiles.count {
                if let tile = rooms[i].tiles[j] as? EnemyTile{
                    if tile.enemy.isAlive{
                        tile.enemy.hp = tile.enemy.maxHealth
                    }
                }
            }
        }
    }
}

extension Dungeon{
    static func semiRandom() -> Dungeon {
        let r1 = Room.genStandardRoom()
        let r2 = Room.genTreasureRoom()
        let r3 = Room.genResourceRoom()
        
        var result = Dungeon(name: "Random Dungeon")
        result.addRoom(r1)
        result.addRoom(r2)
        result.addRoom(r3)
        
        result.addConnection(from: r1, direction: .east, to: r2)
        result.addConnection(from: r1, direction: .west, to: r3)
        
        return result
    }
    
    static func randomInfinity() -> Dungeon {
        var result = Dungeon(name: "Random Dungeon")
        
        let numberOfRooms = Int.random(in: 3...6)
        
        // Generate rooms randomly
        for _ in 1...numberOfRooms {
            let randomRoomType = RoomType.allCases.randomElement() ?? .standard
            let randomRoom = Room.genRoom(type: randomRoomType)
            result.addRoom(randomRoom)
        }
        
        // Connect rooms randomly
        for room in result.rooms {
            let numberOfConnections = 2
            for _ in 1...numberOfConnections {
                let randomDirection = Direction.allCases.randomElement() ?? .north
                if let randomNeighbor = result.rooms.filter({ $0.id != room.id }).randomElement() {
                    result.addConnection(from: room, direction: randomDirection, to: randomNeighbor)
                }
            }
        }

        return result
    }
    
    
    static func random() -> Dungeon {
        var result = Dungeon(name: "Random Dungeon")
        
        let rows = 5
        let cols = 5
        result.grid = [[UUID?]]()
        
        // Generate grid
        for _ in 0..<rows {
            result.grid.append(Array(repeating: UUID?.none, count: cols))
        }
        
        // Create central room (starting point)
        let centralRoom = Room.genRoom(type: .standard)
        result.addRoom(centralRoom)
        result.grid[rows/2][cols/2] = centralRoom.id
        
        // Generate rooms randomly
        let numberOfRooms = Int.random(in: 3...6)
        for _ in 1...numberOfRooms {
            let randomRoomType = RoomType.allCases.randomElement() ?? .standard
            let randomRoom = Room.genRoom(type: randomRoomType)
            result.addRoom(randomRoom)
            
            var placed = false
            while !placed {
                let randomRow = Int.random(in: 0..<rows)
                let randomCol = Int.random(in: 0..<cols)
                
                if let existingRoomId = result.grid[randomRow][randomCol] {
                    let existingRoom = result.lookup(existingRoomId)!
                    
                    for direction in Direction.allCases {
                        let newPos = Direction.newPos(direction: direction, row: randomRow, col: randomCol)
                        let newRow = newPos.row
                        let newCol = newPos.col
                        if Dungeon.isWithinBounds(row: newRow, col: newCol) && (result.grid[newRow][newCol] == nil){
                            result.grid[newPos.row][newPos.col] = randomRoom.id
                            result.addConnection(from: existingRoom, direction: direction, to: randomRoom)
                            
                            placed = true
                            break
                        }
                    }
                }
            }
        }
                
        return result
    }
    
    static func isWithinBounds(row: Int, col: Int) -> Bool {
        return row >= 0 && row < 5 && col >= 0 && col < 5
    }
}
