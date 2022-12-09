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
    @Published var users: [User] = []
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("CarData")
        return ref
    }()
    

    private lazy var userDatabasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("UserData")
        return ref
    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func listenRealtimeDatabase() {
        guard let databasePath = databasePath else {
            return
        }
        guard let userDatabasePath = userDatabasePath else {
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
                    self.cars.append(car)

                } catch {
                    print("an error occurred", error)
                }
            }
        
        userDatabasePath
            .observe(.childAdded) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                json["id"] = snapshot.key
                do {
                    let userData = try JSONSerialization.data(withJSONObject: json)
                    let user = try self.decoder.decode(User.self, from: userData)
                    self.users.append(user)

                } catch {
                    print("an error occurred", error)
                }
            }
    }
    
    func stopListening() {
        databasePath?.removeAllObservers()
        userDatabasePath?.removeAllObservers()
    }
}
