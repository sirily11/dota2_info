//
//  ChartPage.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/26/21.
//

import SwiftUI
//import Charts
import SwiftUICharts

struct ChartPage: View {
    let match: MatchDetails
    
    var body: some View {

        
        let xps: [Double] = match.radiantXPAdv?.map{xp in Double(xp)} ?? []
        let golds: [Double] = match.radiantGoldAdv?.map{xp in Double(xp)} ?? []
        
        return
            GeometryReader { m in
                VStack {
                    HStack{
                        LineView(data: xps, title: "天辉经验领先", legend: "XP Differences",  valueSpecifier: "%.0f")
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                            )
                            .padding([.top, .horizontal])
                        LineView(data: golds, title: "天辉经济领先", legend: "Gold Differences", valueSpecifier: "%.0f")
                            .padding()
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                            )
                            .padding([.top, .horizontal])
                    }.frame(maxHeight: m.size.height * 0.6)
                    HStack {
                        Text("Chat History")
                            .font(.title3)
                        Spacer()
                    }
                    .padding()
                    ChatList(chats: match.chat ?? [], players: match.players ?? [])
                        .padding()
                        .cornerRadius(10)
                        .frame(maxHeight: .infinity)
                }
            }
        }
    
}

struct ChartPage_Previews: PreviewProvider {
    static var previews: some View {
        ChartPage(match: demoMatch)
    }
}
