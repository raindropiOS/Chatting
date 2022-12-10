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
    
    func addUserData(user: User) {
//        guard let key = userDatabasePath!.childByAutoId().key else { return }
        // 삭제를 용이하게 하기 위해
        guard let key = userDatabasePath!.child("\(user.id)").key else { return }
        
        let user = [
            "id" : user.id,
            "nickname" : user.nickname,
            "password" : user.password
        ]
//        let childUpdates = ["/UserData/\(key)": user] : 이 경우 userDatabasePath(이미 UserData 접근함)에 접근해서 UserData 경로를 찾거나 추가한다 => UserData 안에 UserData 경로 추가하고 데이터 생성
        let childUpdates = ["\(key)": user]
        userDatabasePath!.updateChildValues(childUpdates)
        
//        self.userDatabasePath!.setValue([ // 값을 설정해버린다(덮어씌워질 수 있음)
//            "id" : user.id,
//            "nickname" : user.nickname,
//            "password" : user.password
//        ])
    }
    
    func removeUserData(userID: String) {
        let ref = Database.database().reference().child("UserData").child(userID)
        ref.removeValue()
    }
}
