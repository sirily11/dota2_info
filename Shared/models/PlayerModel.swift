//
//  PlayerModel.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/18/21.
//

import Foundation
import SwiftUI

class NetworkPlayerModel{
    let playerURL = "https://api.opendota.com/api/players/"

    
    func fetchPlayer(playerID: String, completion: @escaping (DotaPlayer) -> Void ) {
        guard let url = URL(string: "\(playerURL)\(playerID)" ) else {
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, resp, err) in
            
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                let response = try! JSONDecoder().decode(DotaPlayer.self, from: data)
                completion(response)
            }
 
        }.resume()
    }
    
    func addPlayer(viewContext: NSManagedObjectContext, dotaPlayer: DotaPlayer){
        
    }
}
