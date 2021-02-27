//
//  BuffView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/27/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct BuffView: View {
    let buff: [PermanentBuff]
    let columns = [GridItem(.adaptive(minimum: 80, maximum: 80))]
    var body: some View {
        LazyVGrid(columns: columns){
            ForEach(buff){
                b in
                BuffViewCell(buff: b)
            }
        }
    }
}

struct BuffViewCell: View {
    @EnvironmentObject var heroModel: HeroModel
    let buff: PermanentBuff
    @State var showDetail = false
    
    var body: some View {
        let (skill, item) = heroModel.findBuffById(String(buff.permanentBuff ?? 0))
        
        
        return ZStack(alignment: .bottomTrailing){
            if let skill = skill{
                WebImage(url: URL(string: skill.img?.getAssetURL() ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onTapGesture {
                        showDetail = true
                    }
                    .popover(isPresented: $showDetail, content: {
                        SkillsDetail(skill: skill)
                    })
                 
                
            }
            if let item = item{
                WebImage(url: URL(string: item.img?.getAssetURL() ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
           
                    .onTapGesture {
                        showDetail = true
                    }
                    .popover(isPresented: $showDetail, content: {
                       ItemInfo(item: item)
                    })
              
                
            }
                Text(String(buff.stackCount ?? 0))
                    .padding(3)
                    .background(Color.blue)
                    .offset()
            
        }
        .frame(width: 50, height: 50)

    }

}

struct BuffView_Previews: PreviewProvider {
    static var previews: some View {
        BuffView(buff: [PermanentBuff(permanentBuff: 3, stackCount: 2), PermanentBuff(permanentBuff: 3, stackCount: 240)])
            .environmentObject(HeroModel())
    }
}
