//
//  NetworkError.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 29.03.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingError
}
