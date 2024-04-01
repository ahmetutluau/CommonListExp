//
//  AuthRouter.swift
//  CommonListExp
//
//  Created by Ahmet Utlu on 1.04.2024.
//

import Foundation

enum AuthRouter: EndpointConfiguration {
    
    case login(AuthLoginRequestModel)
    
    var method: HTTPMethod {
        switch self {
        case .login :
            return .POST
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
    
    var queryParameters: QueryStringParameters {
        switch self {
        default:
            return nil
        }
    }
    
    var httpBody: Data? {
        switch self {
        case .login(let model):
            return model.asData
        }
    }
    
    var headers: [CustomHTTPHeader]? {
        return [.accept, .contentType]
    }
    
    var multipartFormData: MultipartFormData {
        return nil
    }
}


extension Encodable {
    
    var asData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
