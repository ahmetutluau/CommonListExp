//
//  Networking.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 29.03.2024.
//

import SwiftUI

protocol NetworkRequester {
    func request<T: Decodable>(_ router: EndpointConfiguration) async throws -> T
}

class Networking: NetworkRequester {
    func request<T>(_ router: EndpointConfiguration) async throws -> T where T : Decodable {
        let request = router.makeUrlRequest()
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                printLog(response: response)
                return response

            } catch {
                throw NetworkError.decodingError
            }
            
        } catch {
            throw NetworkError.requestFailed
        }
    }

    private func printLog<T: Decodable>(response: T) {
        print("\n\n\n")
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        debugPrint(response)
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        print("\n\n\n")
    }
}
