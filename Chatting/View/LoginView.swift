//
//  LoginView.swift
//  Chatting
//
//  Created by 박시현 on 2022/12/09.
//

import SwiftUI

struct LoginView: View {
    @State var isSingnInPresented: Bool = false
    @ObservedObject var carStore: CarStore
    @State private var inputID: String = ""
    @State private var inputPassword: String = ""
    
    var body: some View {
        VStack {
            InputIDPW(inputID: $inputID, inputPassword: $inputPassword)
            Button("let's Sign-in") {
                isSingnInPresented.toggle()
            }
            .foregroundColor(.blue)
        }
        .sheet(isPresented: $isSingnInPresented) {
            SignIn(carStore: carStore, isSingnInPresented: $isSingnInPresented)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(carStore: CarStore())
    }
}

struct InputIDPW: View {
    @Binding var inputID: String
    @Binding var inputPassword: String
    var body: some View {
        VStack {
            HStack {
                Text("ID")
                TextField("", text: $inputID)
                    .border(.black)
            }
            
            HStack {
                Text("PW")
                TextField("", text: $inputPassword)
                    .border(.black)
            }
        }
        .frame(width: 200)
    }
}
