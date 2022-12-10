//
//  SignIn.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import SwiftUI

struct SignIn: View {
    @ObservedObject var carStore: CarStore
    @State private var inputID: String = ""
    @State private var inputPW: String = ""
    @State private var inputNickname: String = ""
    @Binding var isSingnInPresented: Bool
    @State private var showRemoveUser = true
    @State private var idOfUserToBeRemoved: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("ID")
                TextField("input ID", text: $inputID)
            }
            
            HStack {
                Text("PW")
                TextField("input Password", text: $inputPW)
            }
            
            HStack {
                Text("nickname")
                TextField("input nickname", text: $inputNickname)
            }
            
            Button("Done") {
                if inputID.count > 1 && inputPW.count > 1 {
                    let user = User(id: inputID, nickname: inputNickname, password: inputPW)
                    carStore.addUserData(user: user)
                }
                
                isSingnInPresented = false
            }
            
            if showRemoveUser {
                TextField("input user's id to remove", text: $idOfUserToBeRemoved)
                
                Button("Remove") {
                    carStore.removeUserData(userID: idOfUserToBeRemoved)
                }
            }
        }
        .padding()
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(carStore: CarStore(), isSingnInPresented: .constant(true))
    }
}
