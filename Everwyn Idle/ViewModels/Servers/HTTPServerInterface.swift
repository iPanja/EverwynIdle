//
//  ServerInterface.swift
//  Everwyn Idle
//
//  Created by Fletcher Henneman on 12/5/23.
//

import Foundation
import SocketIO

class HTTPServer {
    private let serverAddress = URL(string: "https://panjaco.com/EI/store_data.json")!
    
    var serverResponse: String?
    var httpError: String?
    
    var storeData: [String: [String]] = [:]
    
    init() {
        Task {
            await asyncGetData()
        }
    }
    
    func asyncGetData() async {
        do{
            let (data, _) = try await URLSession.shared.data(from: serverAddress)
            self.storeData = parseData(data)
        }catch{
            httpError = "Error connecting to (http) server"
            print("Error connecting to server, ")
            print(error)
        }
    }
    
    func parseData(_ data: Data) -> [String: [String]]{
        var _merchantInventory: [String: [String]] = [:]
        
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(ServerResponse.self, from: data)
            let merchantData = response.merchants
            _merchantInventory = merchantData.reduce(into: [String: [String]]()) { dict, entry in
                dict[entry.name] = entry.slots
            }
        }catch{
            httpError = "Unable to parse server response"
            print("Unable to parse server response")
        }
        
        return _merchantInventory
    }
}
