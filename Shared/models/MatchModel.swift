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
        let config = Realm.Configuration(schemaVersion: 2)
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
    func findMatchDetailsById(_ matchId: Int, playerID: String?, forceFetch: Bool = false ,completion: @escaping (MatchDetails) -> Void ){
        let history = loadMatchFromDB(matchId: matchId)
        if let history = history{
            if !forceFetch{
                completion(history)
                return
            }
        }
        
        
        guard let url = URL(string: "\(searchURL)\(matchId)" ) else {
            return
        }
    
 
        URLSession.shared.dataTask(with: url){
            (data, resp, err) in
            
            guard let data = data else {
                self.isLoadingMatches = false
                return
                
            }
            
            DispatchQueue.main.async { [self] in
                do{
                let match = try JSONDecoder().decode(MatchDetails.self, from: data)
                    self.storeMatchIntoDB(match: match)
                    completion(match)
                } catch{
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                  
                }
            
            }
        }.resume()
    }
    
    /**
     Helper function to find recent matches
     */
    private func findMatchByPlayerUtil(playerId: String, completion: @escaping ([DotaMatchElement]) -> Void, onError: @escaping (String) -> Void ){
        guard let url = URL(string: "\(matchAbstractURL)\(playerId)/recentMatches" ) else {
            onError("cannot construct url")
            return
        }
        
        URLSession.shared.dataTask(with: url){
           [weak self] (data, resp, err) in
            
            guard let data = data else {
                return
                
            }
            
            DispatchQueue.main.async {
                do{
                let matches = try JSONDecoder().decode([DotaMatchElement].self, from: data)
                completion(matches)
                    
                    
                } catch{
                 onError("Cannot fetch matches")
                }
            
            }
        }.resume()
    }
        
    
    /**
     Get list of match summary user played recently
     */
    func findMatchByPlayer(playerId: String){
        withAnimation{
            isLoadingMatches = true
            selectedPlayer = playerId
        }
        loadMatchesFromDB(playerId: playerId)
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


extension MatchModel{
    
    /**
     Add Match to DB. If exists, then update it
     */
    func storeMatchIntoDB(match: MatchDetails){
        do{
            try realm?.write{
                let storedMatch = realm?.objects(MatchDetailsDB.self).filter("matchID = \(String(match.matchID ?? 0))").first
                if let playerId = selectedPlayer{
                if let storedMatch = storedMatch{
                    storedMatch.replayURL = match.replayURL
                    
                } else{
             
                        let matchDB = match.toDB(playerId: playerId)
                        realm?.add(matchDB)
                        
                        let index = matches.firstIndex{ m in m.id == match.matchID }
                        var newMatch = match.toAbstractMatch(playerID: playerId)
                        newMatch.inDB = true
                        matches[index!] = newMatch
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
    func loadMatchesFromDB(playerId: String){
        let results = realm?.objects(MatchDetailsDB.self).filter("playerId = '\(playerId)'").sorted(byKeyPath: "startTime", ascending: false)
        if let results = results{
            let histories: [DotaMatchElement] = results.map{ r in MatchDetails(from: r).toAbstractMatch(playerID: playerId) }
            matches = histories
        }
    }
    
    func loadMatchFromDB(matchId: Int) -> MatchDetails?{
        let result = realm?.objects(MatchDetailsDB.self).filter("matchID = \(matchId)").first
        if let result = result{
            return MatchDetails(from: result)
        }
        return nil
    }
}

let demoMatch = MatchDetails(matchID: 5840322763, barracksStatusDire: 63, barracksStatusRadiant: 0, cluster: 0, direScore: 37, duration: 1784, engine: 1, firstBloodTime: 19, gameMode: 23, humanPlayers: 10, leagueid: 0, lobbyType: 0, matchSeqNum: 4914938039, negativeVotes: 0, positiveVotes: 0, radiantScore: 9, radiantWin: false, skill: 1, startTime: 1613542889, towerStatusDire: 1974, towerStatusRadiant: 0, replaySalt: 1171182118, seriesID: 0, seriesType: 0, players: [PlayerMatch(matchID: 5840322763, playerSlot: 130, abilityUpgradesArr: [5347,5345,5347,5346,5347,5348,5347,5345,5345,5949,5345,5348,5346,5346,6352,6346,5348,6534,7106], accountID: 178510306, assists: 21, permanentBuffs: [PermanentBuff(permanentBuff: 12, stackCount: 0)], backpack0: 0, backpack1: 0, backpack2: 0, backpack3: 0, deaths: 2, denies: 6, gold: 7696, goldPerMin: 1008, goldSpent: 23155, heroDamage: 27079, heroHealing: 696, heroID: 68, item0: 29, item1: 29, item2: 40, item3: 604, item4: 92, item5: 235, itemNeutral: 212, kills: 10, lastHits: 103, leaverStatus: 0, level: 28, netWorth: 30006, partyID: 4, partySize: 2, towerDamage: 14405, xpPerMin: 1329, personaname: "hhhh", radiantWin: true, startTime: 1613542889, duration: 1784, cluster: 151, lobbyType: 0, gameMode: 23, isContributor: false, patch: 5, region: 5, isRadiant: true, win: 1, lose: 0, totalGold: 35561, totalXP: 39515, kda: 0, abandons:0, rankTier: 51)], patch: 0, region: 5, replayURL: "http://replay151.valve.net/570/5840322763_1171182118.dem.bz2")
