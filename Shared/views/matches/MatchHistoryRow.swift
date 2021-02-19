//
//  MatchHistoryRow.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI
import SwiftDate

extension Int {
    func dateFromMilliseconds() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

struct MatchHistoryRow: View {
    @EnvironmentObject var matchModel: MatchModel
    let match: DotaMatchElement
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("MatchID")
                Spacer()
                Text("\(String(match.id ?? 0))")
            }
       
            HStack{
                Text("\(matchModel.getHeroById("\(match.heroID!)")?.localizedName ?? "No Found")")
                    .font(.title3)
         
                
                if win(){
                    Text("Win")
                        .padding(5)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(10)
                } else{
                    Text("Lose")
                        .padding(5)
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(10)
                }
                
            }
            HStack{
                if let starttime = match.startTime{
                    Text("\(starttime.dateFromMilliseconds().convertTo(region: Region(calendar: Calendars.gregorian, zone: Zones.asiaShanghai, locale: Locales.english)) .toFormat("dd MMM yyyy HH:mm:ss"))")
                        .bold()
                }
               
            }
            HStack{
                Text("Kills: \(match.kills ?? 0)")
                Spacer()
                Text("Deaths: \(match.deaths ?? 0)")
                Spacer()
                Text("Assits: \(match.assists ?? 0)")
            }
        }
    }
    
    private func win()-> Bool{
        if let playerSlot = match.playerSlot{
            if let radiant_win = match.radiantWin{
                if playerSlot <= 127 && radiant_win{
                    return true
                } else if playerSlot > 127 && !radiant_win{
                    return true
                }
            }
        }
        
        return false
    }
}

struct MatchHistoryRow_Previews: PreviewProvider {
    static var previews: some View {
        MatchHistoryRow(match: DotaMatchElement(id: 12345, playerSlot: 3, radiantWin: true, duration: 3005, gameMode: 22, lobbyType: 0, heroID: 16, startTime: 1607233132, version: nil, kills: 4, deaths: 7, assists: 29, skill: nil, partySize: 2, heroes: nil) )
            .environmentObject(MatchModel())
    }
}
