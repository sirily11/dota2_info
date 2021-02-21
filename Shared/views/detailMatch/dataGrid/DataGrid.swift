//
//  DataGrid.swift
//  dota2_info (iOS)
//
//  Created by 李其炜 on 2/21/21.
//

import Foundation
import SwiftUI
import Kingfisher


struct DataGrid {
    var columns: [DataColumn]
    var rows: [DataRow]
}


struct DataColumn: Identifiable {
    var id = UUID()
    var sortKey: String
    var content: AnyView
}

struct DataRow: Identifiable {
    var id = UUID()
    var sortKey: String
    var cells: [DataRowCell]
    var height = 100
}

struct DataRowCell: Identifiable{
    var id = UUID()
    var content: AnyView
    var width = 60
}


let demoColumns = [
    DataColumn(sortKey: "Name", content: AnyView(Text("Name"))),
    DataColumn(sortKey: "Age", content: AnyView(Text("Age"))),
    DataColumn(sortKey: "image", content: AnyView(Text("Image"))),
]

let demoRows = [
   DataRow(sortKey: "first row", cells: [
        DataRowCell(content: AnyView(Text("PA"))),
        DataRowCell(content: AnyView(Text("20"))),
        DataRowCell(content: AnyView(Text("20asdasdasdasdasdasdasdsadasdasdasdasdasdasdasdasdas"))),
   ]),
    DataRow(sortKey: "second row", cells: [
        DataRowCell(content: AnyView(Text("PA"))),
        DataRowCell(content: AnyView(Text("20"))),
        DataRowCell(content: AnyView(Text("20asdasdasdasdiusahdiuashufihsdofjasoidjiaosjdioasjiodjaso")), width: 200),
    ])
]

let demoGrid = DataGrid(
    columns: demoColumns, rows: demoRows
)
