//
//  Car.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import Foundation

struct Car: Codable, Identifiable {
    
    var id: String
    var name: String
    var description: String
    var imageName: String
    var isHybrid: Bool
    
}
