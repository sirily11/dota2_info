//
//  PlayerChartView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI
import SwiftUICharts

struct PlayerChartView: View {
    let player: PlayerMatch
    var body: some View {
        let lht = (player.lhT ?? []).map{ l in Double(l)}
        let goldT = (player.goldT ?? []).map{ l in Double(l)}
        let xpT = (player.xpT ?? []).map{ l in Double(l)}
        let dnT = (player.dnT ?? []).map{ l in Double(l)}
        
        return VStack{
            HStack{
                LineView(data: lht, title: "Last Hits", valueSpecifier: "%.0f")
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                    )
                    .padding([.top, .horizontal])
                
                LineView(data: goldT, title: "Gold", valueSpecifier: "%.0f")
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                    )
                    .padding([.top, .horizontal])
            }
            
            HStack{
                LineView(data: dnT, title: "Denies", valueSpecifier: "%.0f")
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                    )
                    .padding([.top, .horizontal])
                
                LineView(data: xpT, title: "XP", valueSpecifier: "%.0f")
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                    )
                    .padding([.top, .horizontal])
            }
        }
        .frame(height: 800)
    }
}

struct PlayerChartView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerChartView(player: demoPlayer)
    }
}
