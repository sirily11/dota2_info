//
//  PlayerModel.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/18/21.
//

import Foundation
import SwiftUI

class NetworkPlayerModel: ObservableObject{
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
    
    func addPlayer(viewContext: NSManagedObjectContext, dotaPlayer: DotaPlayer?, completion: () -> Void){
        let newPlayer = Player(context: viewContext)
        if let accountID = dotaPlayer?.profile?.accountID{
            newPlayer.userid = Int64(accountID)
        }
        
        if let username = dotaPlayer?.profile?.personaname{
            newPlayer.username = username
        }
        
        if let avatar = dotaPlayer?.profile?.avatarfull{
            newPlayer.avatar = avatar
        }
        
        do{
            try viewContext.save()
            completion()
        } catch{
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deletePlayers(viewContext:NSManagedObjectContext, offsets: IndexSet, players: FetchedResults<Player>) {
        withAnimation {
            offsets.map { players[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
            
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
