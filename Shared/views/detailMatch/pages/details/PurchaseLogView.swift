//
//  PurchaseLogView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PurchaseLogView: View {
    let purchaseLogs: [PurchaseLog]
    
    let rows = [ GridItem(.adaptive(minimum: 80))]
    var body: some View {
        
        LazyVGrid(columns: rows){
            
            ForEach(purchaseLogs){
                log  in
                 PurchaseLogCeil(log: log)
                    .animation(.easeIn)
                    .transition(.scale)
            }
        }.frame(minWidth: 300)
        
    }
}

struct PurchaseLogCeil: View {
    @EnvironmentObject var heroModel: HeroModel
    @State var showInfo = false
    let log: PurchaseLog?
    
    var body: some View {
        let item = heroModel.findItemByName(itemName: log?.key ?? "")
        
        let (hr, min, sec) = (log?.time ?? 0 ).secondsToHoursMinutesSeconds()
        
        Group {
            if let _ = log{
                VStack{
                    if let item = item{
                        if let img = item.img{
                            WebImage(url: URL(string: img.getAssetURL())!)
                                .onTapGesture {
                                    showInfo = true
                                }
                            
                        }
                    }
                    
                    Text("\(hr):\(min):\(sec)")
                    
                }
                .popover(isPresented: $showInfo, content: {
                    ItemInfo(item: item)
                        .frame(width: 400)
                })
            } else{
                EmptyView()
            }
            
        }
    }
}


struct PurchaseLogView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseLogView(purchaseLogs: demoPurchaseLogs)
            .environmentObject(HeroModel())
    }
}
