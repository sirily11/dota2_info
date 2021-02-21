//
//  InfoCard.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI
import SwiftDate

struct InfoCard: View {
    @EnvironmentObject var matchModel: MatchModel
    var match: MatchDetails
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func winText(_ win: Bool) -> AnyView{
        if win {
           return AnyView(Text("Win")
                            .padding(5)
                            .background(Color.green)
                            .cornerRadius(10)
                           )
        } else{
            return AnyView(Text("Lose")
                            .padding(5)
                            .background(Color.red)
                            .cornerRadius(10)
                            )
        }
     
        
    }
    
    var body: some View {
        let (hr, min, secs) = secondsToHoursMinutesSeconds(seconds: match.duration ?? 0)
        let (fhr, fmin, fsec) = secondsToHoursMinutesSeconds(seconds: match.firstBloodTime ?? 0)
        let time = match.startTime?.dateFromMilliseconds().convertTo(region: Region(calendar: Calendars.gregorian, zone: Zones.asiaShanghai, locale: Locales.english)).toFormat("dd MMM yyyy HH:mm:ss")
        
        let gameMode = matchModel.getGameModeById(String(match.gameMode ?? 0))
        
        return VStack{
            HStack{
                VStack{
                    winText(match.radiantWin ?? false)
                    Text("天辉")
                        .font(.title)
                    Text("\(match.radiantScore ?? 0)")
                        .font(.headline)
              
                }
                Spacer()
                VStack{
                    Text(match.skillsDescription)
                        .padding(4)
                        .background(match.skillsColor)
                        .cornerRadius(10)
                        
                        
                    Text("\(gameMode?.localized ?? gameMode?.name ?? "")")
                    Text("\(matchModel.getRegionById(String(match.region ?? 0)))")
                }
                Spacer()
                VStack{
                    winText(!(match.radiantWin ?? false))
                    Text("夜魇")
                        .font(.title)
                    Text("\(match.direScore ?? 0)")
                        .font(.headline)
                  
                }
            }
            .padding()
            
            
            HStack{
                Text("Duration: \(hr):\(min):\(secs)")
                Divider()
                    .frame(height: 20)
                Text(time ?? "No Time")
               
               
            }
           
            
            HStack{
                Text("FirstBlood At: \(fhr):\(fmin):\(fsec)")
                    .foregroundColor(.red)
               
            }
        }
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard(
            match: demoMatch)
            .environmentObject(MatchModel())
    }
}

