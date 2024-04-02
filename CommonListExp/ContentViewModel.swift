//
//  ContentViewModel.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 29.03.2024.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var alertItem: AlertItem?
    
    var service: NetworkRequester
    
    init(service: NetworkRequester) {
        self.service = service
    }
    
    @MainActor
    func login() async {
        do {
            let model = AuthLoginRequestModel(emailAddress: self.email, password: self.password)
            let response: AuthLoginResponseModel = try await service.request(AuthRouter.login(model))
            print(response)
            self.alertItem = AlertItem(title: "Success", message: "Login successful")
        } catch {
            print(error)
            self.alertItem = AlertItem(title: "Error", message: "Login failed")
        }
    }
}

