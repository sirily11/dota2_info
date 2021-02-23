//
//  DatGridView.swift
//  dota2_info
//
//  Created by 李其炜 on 2/21/21.
//

import SwiftUI

extension DataGridView{
    private func getMaxRowCellWidth(index: Int) -> Int{
        var maxWidth = 0
        for row in dataGrid.rows{
            if index >= row.cells.count{
                fatalError("Rowcell's length is less than number of columns")
                
            } else {
                if row.cells[index].width > maxWidth{
                    maxWidth = row.cells[index].width
                }
            }
        }
        
        return maxWidth
    }

}

struct DataGridView: View {
    let dataGrid: DataGrid
    let showHeader: Bool

    var body: some View {
        let maxWidths: [Int] = dataGrid.columns.enumerated().map{ (index, element) in
            return getMaxRowCellWidth(index: index)
            
        }

        VStack(alignment: .leading){
            
                if showHeader{
                    HStack{
                        ForEach(0..<dataGrid.columns.count){ index -> DataCellView in
                            let column = dataGrid.columns[index]
                           
                            return DataCellView(view: column.content,height: 40, width: maxWidths[index])
                        }
                    }
                  
                    .background(Color.primary.opacity(0.4))
                }
               
                    ForEach(dataGrid.rows){
                        row in
                        
                        HStack{
                            ForEach(0..<row.cells.count){ index -> DataCellView in
                               let cell = row.cells[index]
                               return DataCellView(view: cell.content, height: row.height, width: maxWidths[index])
                            }
                    
                        }
                       
                    }
            }

        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .leading)
      
    }

    
}

struct DataCellView: View{
    var view: AnyView
    let height: Int
    let width: Int
    
    var body: some View{
        view
            .frame(width: CGFloat(width), height: CGFloat(height) )
    }
}

struct DatGridView_Previews: PreviewProvider {
    static var previews: some View {
        DataGridView(dataGrid: demoGrid, showHeader: true)
    }
}
