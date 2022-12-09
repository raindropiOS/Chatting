//
//  CarStore.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import Foundation
import FirebaseDatabase

class CarStore : ObservableObject {
    
    @Published var cars: [Car] = []
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("CarData")
        return ref
    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func listenRealtimeDatabase() {
        guard let databasePath = databasePath else {
            return
        }
        databasePath
            .observe(.childAdded) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                json["id"] = snapshot.key
                do {
                    let carData = try JSONSerialization.data(withJSONObject: json)
                    let car = try self.decoder.decode(Car.self, from: carData)
//                    let car = try self.decoder.decode([Car].self, from: carData)
                    self.cars.append(car)
//                    self.cars = car
                } catch {
                    print("an error occurred", error)
                }
            }
    }
    
    func stopListening() {
        databasePath?.removeAllObservers()
    }
}
