//
//  ContentViewModel.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 29.03.2024.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    var service: NetworkRequester
    
    init(service: NetworkRequester) {
        self.service = service
    }
    
    @Published var movies = [MoviesModel]()

    // ... diğer kodlar

    @MainActor
    func getNowPlaying() async {
//        do {
//            let response: MoviesResponseModel = try await service.request(MovieRouter.nowPlaying)
//            self.movies = response.results!
//        } catch {
//            print(error)
//        }
    }
    
    func login() async {
        do {
            let model = AuthLoginRequestModel(emailAddress: "ahmet@test.com", password: "123")
            let response: AuthLoginResponseModel = try await service.request(AuthRouter.login(model))
            print(response.data?.emailAddress ?? "")
        } catch {
            print(error)
        }
    }
}
