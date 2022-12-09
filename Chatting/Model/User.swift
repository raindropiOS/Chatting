//
//  User.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var nickname: String
    var password: String
    
    var _nickname: String {
        if nickname.count > 0 {
            return nickname
        } else {
            return id
        }
    }
}
