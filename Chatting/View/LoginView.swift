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
    
    var body: some View {
        VStack {
            
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
