//
//  ContentView.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var carStore: CarStore = CarStore()
    
    var body: some View {
        VStack {
            CarDataList(carStore: carStore)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
