//
//  APIConstants.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 29.03.2024.
//

import Foundation

struct APIConstants {
    static var baseURL: String {
        return "https://commonlistapi.basefy.com"
    }
}

enum CustomHTTPHeader: String {
    case authentication
    case contentType
    case multiPart
    case deviceId
    case deviceType
    case accept

    
    var key: String {
        switch self {
        case .authentication: return "Authorization"
        case .contentType: return "Content-Type"
        case .multiPart: return "Content-Type"
        case .deviceId: return "DeviceId"
        case .deviceType: return "DeviceType"
        case .accept: return "accept"

        }
    }
    
    var value: String {
        switch self {
        case .authentication: return "Bearer"
        case .contentType: return "application/json"
        case .multiPart: return "multipart/form-data"
        case .deviceId: return "UIDevice.current.identifierForVendor!.uuidString"
        case .deviceType: return "2"
        case .accept: return "application/json"

        }
    }
}
