//
//  SignIn.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import SwiftUI

struct SignIn: View {
    @State private var inputID: String = ""
    @State private var inputPW: String = ""
    @State private var inputNickname: String = ""
    @Binding var isSingnInPresented: Bool
    
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
                    
                }
                
                isSingnInPresented = false
            }
        }
        .padding()
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(isSingnInPresented: .constant(true))
    }
}
