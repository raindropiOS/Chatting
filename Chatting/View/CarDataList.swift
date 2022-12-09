//
//  carDataList.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import SwiftUI

struct CarDataList: View {
    @ObservedObject var carStore: CarStore
    
    var body: some View {
        VStack {
            if carStore.cars.isEmpty {
                Text("car store's cars are empty")
            }
            if carStore.users.isEmpty {
                Text("user empty")
            }
            
            List {
                ForEach(carStore.cars) { car in
                    ListCell(car: car)
                }
            }
            .navigationTitle(Text("EV Cars"))
            .onAppear {
                carStore.listenRealtimeDatabase()
            }
            .onDisappear {
                carStore.stopListening()
            }
        }
    }
}

struct carDataList_Previews: PreviewProvider {    
    static var previews: some View {
        NavigationStack {
            CarDataList(carStore: CarStore())
        }
    }
}
