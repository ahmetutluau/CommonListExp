//
//  ContentView.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 29.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel(service: Networking())
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Login") {
                Task {
                    await viewModel.login()
                }
            }
        }
        .padding()
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: .default(Text("OK")))
        }
    }
}


#Preview {
    ContentView()
}
