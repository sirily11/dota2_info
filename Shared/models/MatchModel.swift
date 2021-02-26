//
//  MatchModel.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import Foundation
import SwiftUI
import RealmSwift
import UserNotifications
import Alamofire

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}


class MatchModel : ObservableObject{
    let matchAbstractURL = "https://api.opendota.com/api/players/"
    let searchURL = "https://api.opendota.com/api/matches/"
    let parseURL = "https://api.opendota.com/api/request/"
    
    @Published var selectedPlayer: String?
    
    @Published var heroData = DotaHero.load("heroes.json")
    @Published var regionData = GameRegion.load("region.json")
    @Published var gameModeData = GameMode.load("game_mode.json")
    
    @Published var isLoadingMatches = false
    @Published var matches: [DotaMatchElement] = []
    private var prevMatches: [DotaMatchElement] = []
    
    var realm: Realm?
    //    var token: NotificationToken?
    
    init() {
        print("File URL: \(Realm.Configuration.defaultConfiguration.fileURL!)")
        let config = Realm.Configuration(schemaVersion: 4)
        Realm.Configuration.defaultConfiguration = config
        self.realm = try! Realm()
    }
    
    /**
     Show Search result. It may return a empty match if no match id matched
     */
    func searchMatchById(_ matchId: String, completion: @escaping ( MatchDetails) -> Void ){
        guard let url = URL(string: "\(searchURL)\(matchId)" ) else {
            return
        }
        
        URLSession.shared.dataTask(with: url){
            (data, resp, err) in
            
            guard let data = data else {
                self.isLoadingMatches = false
                return
                
            }
            
            DispatchQueue.main.async {
                do{
                    let match = try JSONDecoder().decode(MatchDetails.self, from: data)
                    completion(match)
                } catch{
                    let nsError = error as NSError
                    print("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }.resume()
    }
    
    /**
     Get match data. If match exist in DB, then return the data from DB, otherwise, use network result
     */
    func findMatchDetailsById(_ matchId: String, playerID: String?, forceFetch: Bool = false ,completion: @escaping (MatchDetails) -> Void ){
        let history = loadMatchFromDB(matchId: matchId)
        if let history = history{
            if !forceFetch{
                completion(history)
                return
            }
        }
        
        AF.request("\(searchURL)\(matchId)", method: .get).responseDecodable(of: MatchDetails.self){
            result in
            
            if let match = result.value{
                self.storeMatchIntoDB(match: match, player: playerID)
                completion(match)
            } else{
                print("Error")
            }
        }
        
    }
    
    /**
     Helper function to find recent matches
     */
    private func findMatchByPlayerUtil(playerId: String, completion: @escaping ([DotaMatchElement]) -> Void, onError: @escaping (String) -> Void ){
        AF.request("\(matchAbstractURL)\(playerId)/recentMatches", method: .get).responseDecodable(of: [DotaMatchElement].self){
            matches in
            if let value = matches.value{
                completion(value)
            } else{
                onError("Cannot fetch matches")
            }
        }
        
    }
    
    
    /**
     Get list of match summary user played recently
     */
    func findMatchByPlayer(playerId: String?){
        withAnimation{
            isLoadingMatches = true
            selectedPlayer = playerId
        }
        loadMatchesFromDB(playerId: playerId)
        if let playerId = playerId{
            findMatchByPlayerUtil(playerId: playerId, completion: {
                [weak self] matches in
                let tmp = matches.filter{
                    match in
                    let contained = self?.matches.contains{
                        m in
                        m.id == match.id
                    }
                    
                    return !(contained ?? false)
                }
                
                tmp.forEach{
                    m in
                    self?.matches.append(m)
                }
                
                if tmp.count > 0{
                    self?.matches = self?.matches.sorted(by: { (prev, curr) -> Bool in
                        prev.startTime ?? 0 > curr.startTime ?? 0
                    }) ?? []
                }
                
                withAnimation{
                    self?.isLoadingMatches = false
                }
                
            }) { [weak self] (error) in
                print(error)
                withAnimation{
                    self?.isLoadingMatches = false
                }
            }
        } else{
            isLoadingMatches = false
        }
      
    }
    
    /**
     Find newly added match and push notification
     */
    func fetchAndPushNotification(playerId: String){
        findMatchByPlayerUtil(playerId: playerId, completion: {
            [weak self] matches in
            
            let latestMatch = matches.first
            if let matches = self?.matches{
                let exists = matches.contains { (match) -> Bool in
                    return match.id == latestMatch?.id
                }
                if !exists{
                    if let latestMatch = latestMatch{
                        self?.pushNotification(match: latestMatch)
                        self?.findMatchByPlayer(playerId: playerId)
                    }
                }
            }
            
        }) { (error) in
            print(error)
            
        }
    }
    
    func pushNotification(match: DotaMatchElement){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])  {
            success, error in
            if let error = error{
                print("Failed to push: m\(error)")
            } else{
                let content = UNMutableNotificationContent()
                content.attachments = [try! UNNotificationAttachment(identifier: "HeroImage", url: URL(string: "https://steamcdn-a.akamaihd.net/apps/dota2/images/nav/logo.png")!, options: nil) ]
                content.title = "New Match Found"
                content.subtitle = "Match ID: \(String(match.id ?? 0))"
                content.body = "\(match.win() ? "Win" : "Lost"): \(match.kills ?? 0)/\(match.deaths ?? 0)/\(match.assists ?? 0)."
                content.sound = .default
                
                let request = UNNotificationRequest(identifier: "Notification", content: content, trigger: nil)
                UNUserNotificationCenter.current().add(request)
                
            }
            
        }
        
    }
}

/**
 Game Related function
 */
extension MatchModel{
    
    func getHeroById(_ heroId: String) -> DotaHero?{
        return heroData[heroId]
    }
    
    func getRegionById(_ regionId: String) -> String{
        return regionData[regionId] ?? ""
    }
    
    func getGameModeById(_ gameMode: String) -> GameMode?{
        return gameModeData[gameMode]
    }
    
}

/**
 DB Related function
 */
extension MatchModel{
    
    /**
     Add Match to DB. If exists, then update it
     */
    func storeMatchIntoDB(match: MatchDetails, player: String?){
        do{
            try realm?.write{
                let storedMatch = realm?.objects(MatchDetailsDB.self).filter("matchID = \(String(match.matchID ?? 0))").first
                    if let storedMatch = storedMatch{
                        realm?.delete(storedMatch)
                        realm?.add(match.toDB(playerId: player))

                    } else{
                        
                        let matchDB = match.toDB(playerId: player)
                        if matchDB.matchID.value == nil{
                            print("Error!")
                        } else{
                            realm?.add(matchDB)
                        }

                        let index = matches.firstIndex{ m in m.id == match.matchID }
                        var newMatch = match.toAbstractMatch(playerID: player)
                        newMatch.inDB = true
                        
                        if let index = index{
                          
                            matches[index] = newMatch
                        } else{
                            matches.append(newMatch)
                        }
                        
                    }
                }
            
        } catch{
            print("Cannot add match to DB")
        }
    }
    
    /**
     Load matches from database
     */
    func loadMatchesFromDB(playerId: String?){
        if let playerId = playerId{
            let results = realm?.objects(MatchDetailsDB.self).filter("playerId = '\(playerId)'").sorted(byKeyPath: "startTime", ascending: false)
            if let results = results{
                let histories: [DotaMatchElement] = results.map{ r in MatchDetails(from: r).toAbstractMatch(playerID: playerId) }
                matches = histories
            }
        } else{
            let results = realm?.objects(MatchDetailsDB.self).filter("playerId = ''").sorted(byKeyPath: "startTime", ascending: false)
            if let results = results{
                let histories: [DotaMatchElement] = results.map{ r in MatchDetails(from: r).toAbstractMatch(playerID: playerId) }
                matches = histories
            }
        }
    }
    
    func loadMatchFromDB(matchId: String) -> MatchDetails?{
        let result = realm?.objects(MatchDetailsDB.self).filter("matchID = \(matchId)").first
        if let result = result{
            return MatchDetails(from: result)
        }
        return nil
    }
}

/**
 Parse Match
 */
extension MatchModel{
    
    
    func sendParseRequest(matchId: String, completion: @escaping (Int) -> Void){
   
        AF.request("\(self.parseURL)\(matchId)", method: .post).responseJSON{
            response in
            
            switch(response.response?.statusCode){
            case 200:
                let data = response.value as! [String: [String: Int]]
                if let jobId = data["job"]?["jobId"]{
                    print(jobId)
                    completion(jobId)
                }
            default:
                print("Error")
            }
        }
        
    }
    
    func getParseStatus(jobId: String, completion: @escaping (Bool) -> Void ){
        AF.request("\(self.parseURL)\(jobId)", method: .get).responseString{
            result in
            if let data = result.value{
                if data == "null"{
                    completion(true)
                } else{
                    completion(false)
                }
            }
        }
    }
    
}
