//
//  ListCell.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import SwiftUI

struct ListCell: View {
    var car: Car
    
    var body: some View {
        HStack {
            Text(car.name)
        }
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        ListCell(car: Car(id: "", name: "Range Rover", description: "good", imageName: "", isHybrid: false))
    }
}
