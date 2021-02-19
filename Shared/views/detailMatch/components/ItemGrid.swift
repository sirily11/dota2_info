//
//  ItemGrid.swift
//  dota2_info
//
//  Created by 李其炜 on 2/18/21.
//

import SwiftUI
import Kingfisher

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

struct ItemGrid: View {
    let items: [Item?]
    
    var body: some View {
        VStack{
            HStack{
                ItemCeil(item: items[0])
                ItemCeil(item: items[1])
                ItemCeil(item: items[2])
            }
            HStack{
                ItemCeil(item: items[3])
                ItemCeil(item: items[4])
                ItemCeil(item: items[5])
            }
        }
    }
}

struct ItemCeil: View {
    @State var showInfo = false
    let item: Item?
    
    var body: some View {
        Group{
            if let item = item{
                if let img = item.img{
                    KFImage(URL(string: img.getAssetURL())!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .onTapGesture {
                            showInfo = true
                        }
                        .popover(isPresented: $showInfo, content: {
                            ItemInfo(item: item)
                        })
                }
            } else{
                Rectangle()
                    .foregroundColor(.black)
            }
            
            
        
        }
        .frame(width: 40, height: 40, alignment: .center)
    }
}

struct ItemInfo: View {
    let item: Item?
    
    var body: some View {
        Group{
            if let item = item{
                if let img = item.img{
                    VStack{
                        KFImage(URL(string: img.getAssetURL())!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 100)
                        
                        Text("\(item.dname ?? "")")
                        HStack{
                            Text("Cost")
                            Spacer()
                            Text("\(item.cost ?? 0)")
                        }
                        HStack{
                            Text("Cd")
                            Spacer()
                            Text("\(item.cd ?? 0)")
                        }
                        Divider()
                        HStack{
                            Text("Notes")
                            Spacer()
                            Text("\(item.notes ?? "")")
                                .frame(width: 200)
                        }
                    }
                        
                }
            } else{
               Text("No Data")
            }
        }
        .padding()
    }
}


struct ItemGrid_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemGrid(
                items: [Item(hint: nil, id: nil, img: "/apps/dota2/images/items/stormcrafter_lg.png", dname: "Item", qual: nil, cost: nil, notes: nil, cd: nil, lore: nil, charges: nil), nil, nil, nil, nil, nil ])
            ItemInfo(
                item: Item(hint: nil, id: nil, img: "/apps/dota2/images/items/stormcrafter_lg.png", dname: "Item", qual: nil, cost: 1200, notes: nil, cd: 10, lore: nil, charges: nil) )
        }
    }
}
